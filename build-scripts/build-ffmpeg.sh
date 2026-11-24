#!/usr/bin/env bash
# Builds the ffmpeg and ffprobe that ship inside Toob Stash.
#
# What this is: an LGPL build of FFmpeg from a pinned commit, with LAME
# (LGPL) for MP3. No GPL parts, no non-free parts, nothing fetched that is
# not checked against a recorded hash. The exact versions live in
# scripts/sidecars.lock.json.
#
# Why build instead of download: the licence position is provable (the
# configure line below is the whole story), and the binaries are small
# because only what the app uses is switched on.
#
# Encoders: H.264 and HEVC come from the operating system (VideoToolbox on
# macOS, Media Foundation on Windows). There is deliberately no libx264.
#
# Usage: scripts/build-ffmpeg.sh [out-dir]      (default: src-tauri/binaries)
# macOS produces universal binaries; Windows (from MSYS2) and Linux build for the host only.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="${1:-$ROOT/src-tauri/binaries}"
WORK="${TOOB_BUILD_DIR:-$ROOT/.build/ffmpeg}"
LOCK="$ROOT/scripts/sidecars.lock.json"
JOBS="$(getconf _NPROCESSORS_ONLN 2>/dev/null || echo 4)"

lock() { python3 -c "import json,sys; d=json.load(open('$LOCK')); print(d$1)"; }
FFMPEG_REPO="$(lock "['ffmpeg']['repo']")"
FFMPEG_COMMIT="$(lock "['ffmpeg']['commit']")"
FFMPEG_TAG="$(lock "['ffmpeg']['tag']")"
LAME_URL="$(lock "['lame']['url']")"
LAME_SHA="$(lock "['lame']['sha256']")"
LAME_VERSION="$(lock "['lame']['version']")"

sha256() { if command -v sha256sum >/dev/null; then sha256sum "$1" | cut -d' ' -f1; else shasum -a 256 "$1" | cut -d' ' -f1; fi; }

mkdir -p "$WORK" "$OUT"

# ---- sources, pinned and checked ------------------------------------------
if [ ! -d "$WORK/ffmpeg-src/.git" ]; then
  git init -q "$WORK/ffmpeg-src"
  git -C "$WORK/ffmpeg-src" remote add origin "$FFMPEG_REPO"
fi
git -C "$WORK/ffmpeg-src" fetch -q --depth 1 origin "$FFMPEG_COMMIT"
git -C "$WORK/ffmpeg-src" checkout -q --force FETCH_HEAD
[ "$(git -C "$WORK/ffmpeg-src" rev-parse HEAD)" = "$FFMPEG_COMMIT" ] || { echo "ffmpeg source is not the pinned commit" >&2; exit 1; }

if [ ! -f "$WORK/lame.tar.gz" ] || [ "$(sha256 "$WORK/lame.tar.gz")" != "$LAME_SHA" ]; then
  curl -fsSL --retry 3 -o "$WORK/lame.tar.gz" "$LAME_URL"
fi
[ "$(sha256 "$WORK/lame.tar.gz")" = "$LAME_SHA" ] || { echo "LAME source does not match its recorded checksum" >&2; exit 1; }

# ---- what is switched on ---------------------------------------------------
# Everything FFmpeg can read stays on (demuxers, decoders, parsers,
# protocols): the downloader hands it whatever a site serves. Writing is
# limited to what the app produces.
ENCODERS="aac,libmp3lame,mjpeg,png,pcm_s16le,flac"
MUXERS="mp4,mov,ipod,mp3,matroska,webm,mpegts,adts,ogg,opus,flac,wav,image2,mjpeg,null,segment,ffmetadata,webvtt,srt,ass,hls"
FILTERS="aresample,aformat,anull,atrim,asetpts,volume,amix,anullsrc,acopy,apad,adelay,scale,crop,pad,format,fps,null,copy,trim,setpts,setsar,concat,transpose,tpad,tile,select,thumbnail,overlay,color,fade,afade,rotate,hflip,vflip,colorchannelmixer,blend,split,atempo,asetrate,hue,lut,lutyuv,lutrgb,colorlevels,gblur,unsharp,vignette"

# Windows has its own threads; everything else uses pthreads.
case "$(uname -s)" in MINGW*|MSYS*) THREADS="--disable-pthreads --enable-w32threads" ;; *) THREADS="--enable-pthreads" ;; esac

common_flags() {
  cat <<FLAGS
--disable-debug --disable-doc --disable-ffplay --disable-autodetect --enable-small
--disable-shared --enable-static $THREADS
--disable-indevs --disable-outdevs
--disable-encoders --disable-muxers --disable-filters
--enable-muxer=$MUXERS --enable-filter=$FILTERS
--enable-libmp3lame --enable-zlib
FLAGS
}

# build_one <name> <ffmpeg configure flags...>; env: LAME_HOST, ARCH_CFLAGS, ARCH_LDFLAGS
build_one() {
  local name="$1"; shift
  local prefix="$WORK/$name/prefix"
  rm -rf "$WORK/$name"; mkdir -p "$WORK/$name/lame" "$WORK/$name/ffmpeg" "$prefix"

  tar -xzf "$WORK/lame.tar.gz" -C "$WORK/$name/lame" --strip-components 1
  (
    cd "$WORK/$name/lame"
    # LAME 3.100 exports a symbol in its list that its own source no longer defines.
    sed -i.bak '/lame_init_old/d' include/libmp3lame.sym
    CFLAGS="-O2 ${ARCH_CFLAGS:-}" LDFLAGS="${ARCH_LDFLAGS:-}" ./configure --prefix="$prefix" --disable-shared --enable-static --disable-frontend --disable-decoder --disable-dependency-tracking ${LAME_HOST:+--host="$LAME_HOST"} >/dev/null
    make -j"$JOBS" >/dev/null
    make install >/dev/null
  )
  (
    cd "$WORK/$name/ffmpeg"
    # shellcheck disable=SC2046
    "$WORK/ffmpeg-src/configure" --prefix="$prefix" $(common_flags) \
      --extra-cflags="-I$prefix/include ${ARCH_CFLAGS:-}" --extra-ldflags="-L$prefix/lib ${ARCH_LDFLAGS:-}" \
      "$@" > configure.log || { tail -30 ffbuild/config.log >&2; exit 1; }
    make -j"$JOBS" ffmpeg ffprobe >/dev/null
  )
  # Refuse to ship anything that is not LGPL.
  local licence
  licence="$(grep -E '^#define FFMPEG_LICENSE' "$WORK/$name/ffmpeg/config.h" | cut -d'"' -f2)"
  case "$licence" in
    "LGPL version 2.1 or later"|"LGPL version 3 or later") ;;
    *) echo "ffmpeg came out as \"$licence\", which is not LGPL. Not shipping it." >&2; exit 1 ;;
  esac
}

SYSTEM="$(uname -s)"
if [ "$SYSTEM" = "Darwin" ]; then
  export MACOSX_DEPLOYMENT_TARGET="${MACOSX_DEPLOYMENT_TARGET:-11.0}"
  MAC_FLAGS=(--enable-videotoolbox --enable-audiotoolbox --enable-securetransport "--enable-encoder=$ENCODERS,h264_videotoolbox,hevc_videotoolbox,aac_at" --cc=clang)
  for arch in arm64 x86_64; do
    ARCH_CFLAGS="-arch $arch -mmacosx-version-min=$MACOSX_DEPLOYMENT_TARGET" ARCH_LDFLAGS="-arch $arch -mmacosx-version-min=$MACOSX_DEPLOYMENT_TARGET" \
    LAME_HOST="$([ "$arch" = arm64 ] && echo aarch64-apple-darwin || echo x86_64-apple-darwin)" \
      build_one "mac-$arch" --arch="$arch" --target-os=darwin --enable-cross-compile "${MAC_FLAGS[@]}"
  done
  for tool in ffmpeg ffprobe; do
    lipo -create "$WORK/mac-arm64/ffmpeg/$tool" "$WORK/mac-x86_64/ffmpeg/$tool" -output "$OUT/$tool-universal-apple-darwin"
    strip -x "$OUT/$tool-universal-apple-darwin"
    chmod 755 "$OUT/$tool-universal-apple-darwin"
  done
  INFO_FROM="$WORK/mac-arm64/ffmpeg"
  BUILT="ffmpeg-universal-apple-darwin ffprobe-universal-apple-darwin"
elif case "$SYSTEM" in MINGW*|MSYS*) true ;; *) false ;; esac; then
  # Windows, from an MSYS2 MINGW64 shell (gcc, make, nasm, zlib). H.264 and HEVC
  # come from Windows itself (Media Foundation), https from Windows too (Schannel).
  # Linked statically so the two programs need nothing beside them. The file name
  # carries the app's own target name, which is what the bundler looks for.
  TRIPLE="x86_64-pc-windows-msvc"
  ARCH_LDFLAGS="-static" \
    build_one win-x64 --arch=x86_64 --target-os=mingw32 --pkg-config-flags=--static \
      --enable-mediafoundation --enable-schannel "--enable-encoder=$ENCODERS,h264_mf,hevc_mf"
  for tool in ffmpeg ffprobe; do
    cp "$WORK/win-x64/ffmpeg/$tool.exe" "$OUT/$tool-$TRIPLE.exe"
    strip "$OUT/$tool-$TRIPLE.exe" || true
  done
  INFO_FROM="$WORK/win-x64/ffmpeg"
  BUILT="ffmpeg-$TRIPLE.exe ffprobe-$TRIPLE.exe"
else
  TRIPLE="$(rustc -vV 2>/dev/null | sed -n 's/^host: //p')"
  TRIPLE="${TRIPLE:-$(uname -m)-unknown-linux-gnu}"
  # No system H.264 encoder on Linux. This build is for development and tests only.
  build_one host "--enable-encoder=$ENCODERS" --enable-openssl 2>/dev/null || build_one host "--enable-encoder=$ENCODERS"
  for tool in ffmpeg ffprobe; do
    cp "$WORK/host/ffmpeg/$tool" "$OUT/$tool-$TRIPLE"
    strip "$OUT/$tool-$TRIPLE" || true
    chmod 755 "$OUT/$tool-$TRIPLE"
  done
  INFO_FROM="$WORK/host/ffmpeg"
  BUILT="ffmpeg-$TRIPLE ffprobe-$TRIPLE"
fi

# ---- a record of exactly what was built ------------------------------------
{
  echo "FFmpeg $FFMPEG_TAG (commit $FFMPEG_COMMIT)"
  echo "Source: $FFMPEG_REPO"
  echo "Licence: $(grep -E '^#define FFMPEG_LICENSE' "$INFO_FROM/config.h" | cut -d'"' -f2)"
  echo "Linked library: LAME $LAME_VERSION (LGPL), source sha256 $LAME_SHA"
  echo "Configure line:"
  grep -E '^#define FFMPEG_CONFIGURATION' "$INFO_FROM/config.h" | cut -d'"' -f2 | sed "s#$WORK#<build>#g"
  echo "Build script: scripts/build-ffmpeg.sh in https://github.com/StaticMassive/ToobStash"
} > "$OUT/ffmpeg-build-info.txt"

for f in $BUILT; do
  echo "built $f  $(du -h "$OUT/$f" | cut -f1)  sha256 $(sha256 "$OUT/$f")"
done

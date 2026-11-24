#!/usr/bin/env bash
# Builds the bundled JavaScript helper (QuickJS-NG's `qjs`) from its pinned
# source into src-tauri/binaries/qjs-universal-apple-darwin.
#
# The downloader runs a site's player script through it. The project's own
# ready-made Mac programs only start on the newest macOS, so it is built here
# for the same oldest macOS as the app. Plain cc, no cmake. About 30 seconds.
#
# On Windows (from an MSYS2 MINGW64 shell) it builds qjs-x86_64-pc-windows-msvc.exe
# the same way, linked statically.
#
# Usage: scripts/build-qjs.sh [out-dir]
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="${1:-$ROOT/src-tauri/binaries}"
LOCK="$ROOT/scripts/sidecars.lock.json"
export MACOSX_DEPLOYMENT_TARGET="${MACOSX_DEPLOYMENT_TARGET:-11.0}"
case "$(uname -s)" in
  Darwin) SYSTEM=mac; NAME="qjs-universal-apple-darwin" ;;
  MINGW*|MSYS*) SYSTEM=windows; NAME="qjs-x86_64-pc-windows-msvc.exe" ;;
  *) echo "build-qjs.sh builds on a Mac or on Windows." >&2; exit 1 ;;
esac
sha256() { if command -v sha256sum >/dev/null; then sha256sum "$1" | cut -d' ' -f1; else shasum -a 256 "$1" | cut -d' ' -f1; fi; }
mkdir -p "$OUT"

read -r VERSION URL SHA < <(python3 - "$LOCK" <<'PY'
import json, sys
d = json.load(open(sys.argv[1]))["quickjs"]
print(d["version"], d["url"], d["sha256"])
PY
)

DEST="$OUT/$NAME"
STAMP="$OUT/qjs-source.stamp"
WANT="$SHA $MACOSX_DEPLOYMENT_TARGET $(sha256 "$0")"
if [ -f "$DEST" ] && [ "$(cat "$STAMP" 2>/dev/null)" = "$WANT" ]; then
  echo "qjs $VERSION already built -> $DEST"
  exit 0
fi

WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT
curl -fsSL --retry 3 -o "$WORK/src.tar.gz" "$URL"
if [ "$(sha256 "$WORK/src.tar.gz")" != "$SHA" ]; then
  echo "QuickJS-NG $VERSION source does not match its recorded checksum. Not using it." >&2
  exit 1
fi
mkdir "$WORK/src" && tar -xzf "$WORK/src.tar.gz" -C "$WORK/src" --strip-components=1

# The unfinished file keeps a name Windows will run.
PART="$OUT/.part-$NAME"
SOURCES="qjs.c gen/repl.c gen/standalone.c quickjs.c quickjs-libc.c libregexp.c libunicode.c dtoa.c"
if [ "$SYSTEM" = mac ]; then
  (
    cd "$WORK/src"
    for arch in arm64 x86_64; do
      # shellcheck disable=SC2086
      cc -arch "$arch" -O2 -w -funsigned-char -D_GNU_SOURCE -DQUICKJS_NG_BUILD \
        -o "$WORK/qjs-$arch" $SOURCES -lm -lpthread
    done
  )
  lipo -create "$WORK/qjs-arm64" "$WORK/qjs-x86_64" -output "$PART"
  strip -x "$PART"
else
  (
    cd "$WORK/src"
    # shellcheck disable=SC2086
    gcc -O2 -w -funsigned-char -D_GNU_SOURCE -DQUICKJS_NG_BUILD -DWIN32_LEAN_AND_MEAN -D_WIN32_WINNT=0x0602 \
      -o "$WORK/qjs.exe" $SOURCES -lm -lpthread -static
  )
  cp "$WORK/qjs.exe" "$PART"
  strip "$PART"
fi
chmod 755 "$PART"
# It has to answer before it is kept.
[ "$("$PART" -e 'console.log(6*7)')" = 42 ] || { echo "The built qjs does not run." >&2; exit 1; }
mv "$PART" "$DEST"
echo "$WANT" > "$STAMP"
if [ "$SYSTEM" = mac ]; then echo "qjs $VERSION -> $DEST  ($(lipo -archs "$DEST"), macOS $MACOSX_DEPLOYMENT_TARGET+)"; else echo "qjs $VERSION -> $DEST"; fi

# Toob Stash website: everything the builder needs

This one file has everything for building the Toob Stash website: what to say, the order of the sections, the rules, and a working link for every logo, screenshot and video. Nothing else is needed.

- **All media in one zip:** https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/toobstash-site-media.zip (15 MB: `brand/`, `shots/`, `loops/`)
- **Single files:** every file has its own link below. All links start with
  `https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/`
- **Host them with the site.** Download the files and put them on the website itself. Don't point `<img>` or `<video>` tags at these links: they are for fetching the files, not for serving pages.
- **The two download buttons are different.** Those links *are* used on the live page as they are (section 4.1).

---

## 1. What Toob Stash is, in one breath

Toob Stash is a free app for Mac and Windows that saves videos from the sites you already watch and lets you edit them straight away. Trim, cut, stack clips, add titles, logos, effects and transitions, then export one finished video. **One app for downloading and editing**: no tools to chain together and no uploading to someone else's website.

The site has one job: show how quick it is to go **from a link to a finished edit**, and get people to press **Download**.

### Who it is for

People who make short edits from videos they find online: clips for a reel, a highlight from a long stream, a reaction, a mash-up of a few videos with their own logo on top. Some will have used a separate downloader and a separate editor before; many will never have edited anything. The tone is a friendly, capable tool, not a professional suite.

### The three things to get across, in this order

1. **Paste a link, and it's yours.** Paste it into Toob Stash (or press ⌘V / Ctrl+V anywhere in the window), choose video or sound only and a size, then press Download.
2. **Edit it right there.** It is already on the timeline, alongside your other clips, your own videos and pictures, titles, effects and transitions.
3. **Export one file.** MP4, MOV, M4A or MP3, in the shape you want (16:9, 9:16, 4:3, 1:1).

One more thing no other tool does deserves its own section: **trim before you download.** A looked-up video lands on the timeline straight away, drawn from the site's own preview pictures. You can trim, cut and arrange it, then download **only the parts you kept**.

---

## 2. Rules the copy and pictures must follow

These are fixed.

- **Never name any video site or social network, and never show their logos, colours or icons.** That covers headlines, alt text, captions, file names, meta tags, FAQ answers and photographs. Say "the sites you already watch", "your favourite sites", "social sites" or "almost any public video link". The app follows the same rule.
- **Don't promise "every video".** Toob Stash saves videos that **anyone can open**, never anything behind a sign-in, a paywall or a members-only page. Say "almost any public video link", or "if anyone can watch it, you can stash it".
- **It is free.** No trial, no account, no watermark. Say so plainly.
- **Mac and Windows.** Two download buttons: "Download for Mac" (macOS 11 or later) and "Download for Windows" (Windows 10 or 11, 64-bit). Show the one that matches the visitor's computer first and larger; the other sits beside it, smaller.
- **Rights line.** Include one short, calm line about using videos you have the right to use, in the FAQ and the footer. No legal wall.
- **Plain words.** Don't use "seamless", "powerful", "revolutionary", "AI-powered", "unleash" or "elevate". The app talks like a helpful person ("Downloading.", "Saved.", "This one needs a sign-in."), and the site should too.
- **Parent brand: Static Massive** (staticmassive.com). The app's top bar says "by Static Massive". Put the same line in the site's footer, with the Static Massive logo (section 6).

---

## 3. Brand

### Logo

- **Mark:** an old tube TV with a blue download arrow on its screen. The name is a pun: "Toob" sounds like "tube". No face on the TV.
- **Lockup:** the mark next to "Toob Stash." with a blue full stop, light on dark. Use it in the site header.
  - The name is set in **Archivo**, weight 800, width 112 % (`font-stretch: 112%`), letter-spacing −0.02em.
  - Load Archivo from Google Fonts with its width axis: `https://fonts.googleapis.com/css2?family=Archivo:wdth,wght@62..125,100..900&display=swap`. Without it, the lockup's name falls back to a plain font.
- **App icon:** the 1024 px PNG, for favicons and any big app-icon moment.

The file links are in section 6.

### Colours

The site uses the app's own colours, so the screenshots sit naturally in the page. Dark only.

| Role | Hex |
| --- | --- |
| Page background | `#14171c` |
| Raised surface (cards, panels) | `#1d2129` |
| Second surface (buttons, wells) | `#262b35` |
| Deepest well (inputs) | `#171a20` |
| Text | `#e8ecf3` |
| Secondary text | `#b7bfcc` |
| Quiet text | `#8b93a3` (on `#14171c` only, 4.5:1) |
| Accent (links, selection, the dot in the logo) | `#5b8def` |
| Text on accent | `#0f1115` |
| Download / Export button | `#d9503f` (the app's own button colour) |

### Type

- **Headlines:** Archivo, 800, width 112 %, tight letter-spacing (about −0.03em). Large and confident.
- **Body:** `system-ui, -apple-system, "Segoe UI", sans-serif`, the same as the app.
- **Numbers and timecodes:** tabular figures.
- **Corners:** 6, 8 and 10 px in the app. Cards on the site can go to 16 px.

---

## 4. The page, section by section

One long scrolling page. The top bar holds the logo, three anchor links (How it works · Features · FAQ) and the Download button. The copy below is a first draft: edit it freely, but keep the rules in section 2.

### 4.1 Hero

- **Headline:** "Save it. Cut it. Post it."
  - Alternatives: "From link to edit in one app." / "Every clip you love, in one stash."
- **Subhead:** "Toob Stash saves videos from the sites you already watch and lets you edit them on the spot. Trim, stack, add titles and effects, and export one finished video. Free for Mac and Windows."
- **Download for Mac**
  - Colour: red `#d9503f`.
  - Link: `https://github.com/StaticMassive/toobstash-downloads/releases/latest/download/ToobStash-mac.dmg`
  - Small line under it: "Free · macOS 11 or later".
- **Download for Windows**, beside it:
  - Link: `https://github.com/StaticMassive/toobstash-downloads/releases/latest/download/ToobStash-windows.exe`
  - Small line under it: "Free · Windows 10 or 11".
- **Which button comes first:** for a visitor on Windows, swap the order, and which one is red.
- **How the download links work:**
  - Use them exactly as they are, as plain links, without `target="_blank"`.
  - A click starts the download and the visitor **stays on the page**; no GitHub page opens.
  - They always give the newest version, so they never need changing.
  - The Mac file is about 70 MB and the Windows file about 32 MB.
- **A quiet second button**, "See how it works", scrolls to 4.3.
- **Picture:** `01-editor.png`, the whole app with a timeline built, in a simple Mac window frame (rounded corners, three window dots, a soft shadow). It can tilt slightly into place on load. Better still, use a probe-lens photo (section 5) with this screenshot on the laptop's screen.

### 4.2 Three steps, one app

Three cards in a row, stacking on a phone. Each has a screenshot, a short title and one line.

1. **Paste a link.** `08-look-up.png`, cropped to the top bar and the Download settings, or whole. "Copy a link, press Paste. Pick video or sound only and a size."
2. **It downloads.** `08-downloads.png`. "Saved to your computer, in a format that plays everywhere."
3. **Edit and export.** `01-editor-timeline.png`. "It's already on the timeline. Cut, stack, add titles, export."

### 4.3 How it works: the scrolling walkthrough

This is the centrepiece. It uses the five short animations from the app's own first-run walkthrough, which play real clips.

- **Desktop layout:** two columns.
  - One side has a large frame that stays pinned while the page scrolls (`position: sticky`).
  - The other side has five text blocks, one per step.
  - When a block reaches the middle of the screen, the frame cross-fades to that step's loop, and a small progress rail (1–5) fills in.
- **On a phone:** no pinning. Each step's loop sits above its text.
- **Video tags:**
  - Use `autoplay muted loop playsinline preload="metadata"`, with the poster image set.
  - Give both sources: the `.webm` first, then the `.mp4`.
  - Only play the loop that is on screen; pause the others.
  - With `prefers-reduced-motion`, show the posters instead of playing.

| Step | Loop / poster | Title | Text |
| --- | --- | --- | --- |
| 1 | walkthrough-1 | Get a video | Copy a video's link and paste it. Choose what to save, press Download, and it lands in your Downloads list. |
| 2 | walkthrough-2 | Build your timeline | Drag a saved clip onto a track. Drag your own videos, photos and logos in from the desktop, onto the timeline or straight onto the picture. |
| 3 | walkthrough-3 | Trim, cut and move | Drag an edge to trim, click with the blade to cut, drag a clip to move it. Right-click any clip for copy, paste, detach audio and more. |
| 4 | walkthrough-4 | Make it look right | Click a picture to move and resize it. Colour, blur, sharpen and vignette on every clip. Titles in any font, typed right on the picture. |
| 5 | walkthrough-5 | Export | Mark the in and out points, pick MP4, MOV, M4A or MP3, and press Export. One finished file. |

Under the section, `09-walkthrough.png` (the whole walkthrough window) can sit with the line "The same walkthrough opens the first time you start the app, and any time from Settings."

### 4.4 Trim before you download

A wide two-part section: picture on one side, words on the other.

- **Picture:** `08-look-up.png`. The timeline at the bottom shows the looked-up video as a "not downloaded" clip drawn from preview pictures.
- **Title:** "Trim first. Download only what you keep."
- **Text:** "Look up a two-hour stream and it's on your timeline in seconds, before anything downloads. Cut out the minute you want, then press Download. Toob Stash fetches only the parts you kept."

### 4.5 Features

Six cards: a 3×2 grid on desktop, one column on a phone. Each card has a picture, a title and two lines.

| Picture | Title | Text |
| --- | --- | --- |
| `02-effects-panel.png` (or `02-effects.png`) | Effects and transitions | Colour, black and white, blur, sharpen, vignette. Cross dissolve, dip to black or white, push. |
| `05-title-typing.png` | Titles on the picture | Add a title with the T key. Double-click it in the preview and type. Any font, colour, shadow or box. |
| `03-clip-menu.png` | Right-click everything | Copy, paste, duplicate, split, disable, detach audio, copy a clip's look. Save any frame as a picture on your desktop. |
| `01-editor-preview.png` | Picture in picture | Stack up to three picture tracks. Move, resize, turn, crop and blend each one, right in the preview. |
| `04-timeline-settings.png` | Any shape | 16:9, 9:16, 4:3 or 1:1, or let it follow your first clip. Lock the timeline to your in and out points. |
| `06-help.png` | Help when you want it | Turn on Help and hold the pointer over anything for a second to see what it does. |

### 4.6 Export

- **Picture:** `07-export.png`, or the cropped panel `07-export-panel.png`.
- **Title:** "One finished file."
- **Text:** "MP4 and MOV keep the picture; M4A and MP3 are sound only. Choose the size and frame rate, press Export, done. Everything happens on your computer: nothing is uploaded."

### 4.7 FAQ

Use an accordion. Draft answers:

- **Is it really free?** Yes. No trial, no account, no watermark.
- **Which sites does it work with?** Almost any site with public videos: if anyone can watch it without signing in, Toob Stash can usually save it. Sites change often, so Toob Stash keeps its downloader up to date by itself.
- **Does it work on Windows?** Yes. Windows 10 or 11, 64-bit. Same app, same features.
- **How do I get updates?** Toob Stash checks by itself. When a new version is out, an **Update** button appears at the top of the window. Click it and the app updates and restarts.
- **Where do my videos go?** To a folder you choose, Movies or Downloads to start with. Nothing is uploaded anywhere.
- **Can I use my own videos and pictures?** Yes. Press Import in the Downloads panel. On a Mac you can also drag them in from Finder.
- **Can I use any video I save?** Save and edit videos you have the right to use: your own, ones made to be shared, or ones the owner has said you can use.
- **My Mac says it can't check the app.** Toob Stash is free and isn't registered with Apple, so this happens the first time only. Click **Done** on the warning. Open **System Settings → Privacy & Security**, scroll down and click **Open Anyway**. Then open Toob Stash from Applications again.
- **Windows says "Windows protected your PC".** Toob Stash is free and isn't registered with Microsoft, so this happens the first time only. Click **More info**, then **Run anyway**, and follow the installer.

### 4.8 Final call and footer

- **Last band:** the app icon large, "Your next edit is one link away.", and both download buttons again.
- **Footer:**
  - "by Static Massive" with the Static Massive logo, linking to https://staticmassive.com.
  - The line "Use videos you have the right to use."
  - A "Contact" link: `mailto:info@staticmassive.com`.
  - © 2026 Static Massive.
- **Privacy:** the app collects nothing. If the site adds visitor analytics or cookies, add a short privacy page saying so; otherwise no privacy page is needed.

### Install steps

Show these right under the buttons, or in a small "How to install" panel that opens after the download starts.

**Mac:**
1. Open the downloaded file.
2. Drag Toob Stash onto the Applications folder.
3. Open Applications and double-click Toob Stash.
4. The first time only, your Mac says it can't check the app:
   - click **Done**;
   - open **System Settings → Privacy & Security**, scroll down and click **Open Anyway**;
   - open Toob Stash again.

**Windows:**
1. Open the downloaded file.
2. The first time, Windows shows "Windows protected your PC": click **More info**, then **Run anyway**.
3. Follow the installer, then open Toob Stash from the Start menu.

---

## 5. Optional: probe-lens photographs

Brandon would like a few photographs of the app on a real laptop screen, shot with a **probe lens**. A probe lens has a long, thin barrel with the glass at the tip. It gets millimetres from things and gives an extreme close-up with a wide, deep, "bug's-eye" perspective.

**How to make them:**
1. **Generate the scene with a plain green screen on the laptop.** Image generators can't draw the app's interface properly.
2. **Put the real screenshot on that screen yourself.** Use a four-corner perspective warp, then add a little glow, reflection and light falloff. Use `01-editor.png`, `02-effects.png` or `05-title-typing.png`.
3. **Keep every logo off every device:** no logo on the laptop lid, no app icons, no social-site screens on any phone in the shot.
4. **Sizes:** make at least three, at 16:9 and 4:5, so the hero has one for desktop and one for phones.

Starting prompts:

- **Keyboard horizon:** "Probe lens macro photograph, lens tip between the keys of a dark aluminium laptop keyboard, looking along the keys toward a glowing laptop screen in the background, screen blank pure green for compositing, warm golden-hour light from a window on the left, dust motes, cinematic, no logos, no text."
- **Mid-drag:** "Probe lens extreme close-up at fingertip height on a laptop trackpad, one finger mid-swipe in soft motion blur, the laptop screen rising above like a wall, screen blank pure green, cool blue screen light on the finger, dark desk, no logos."
- **Pilot's desk:** "Probe lens low-angle photograph across a wooden desk, a small FPV racing drone and FPV goggles in the foreground looming large, a laptop behind them with a blank pure green screen, evening light, no brand marks."
- **Phone to laptop:** "Probe lens photograph from desk level, a smartphone lying face up in the foreground with a blank pure green screen, a laptop behind it with a blank pure green screen, a cable between them, soft daylight, minimalist desk, no logos, no text."

---

## 6. Every file, with its link

Base: `https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/`

### Brand

| File | What it is | Link |
| --- | --- | --- |
| `toobstash-lockup.svg` | Icon + "Toob Stash." name, light on dark. Site header. | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/brand/toobstash-lockup.svg |
| `toobstash-icon.svg` | The icon alone, as a vector. Favicon, small spots. | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/brand/toobstash-icon.svg |
| `icon-1024.png` | The 1024 × 1024 app icon. Favicon set, social preview, final band. | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/brand/icon-1024.png |
| `static-massive.svg` | The Static Massive logo for the footer. It takes the text colour around it (`currentColor`). | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/brand/static-massive.svg |

### Screenshots

The full-window screenshots are 2880×1800: the window at 1440×900, captured at twice the pixels for sharp Retina displays. Show them at 1440 px wide or less.

| File | Size | What it shows | Alt text | Link |
| --- | --- | --- | --- | --- |
| `01-editor.png` | 2880×1800 | The whole app: Downloads, a preview with a title over the picture, the Inspector, a timeline with four tracks. | Toob Stash editing a video: a title over the picture and clips stacked on the timeline. | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/shots/01-editor.png |
| `01-editor-timeline.png` | 2848×880 | The timeline panel alone. | The Toob Stash timeline with picture and sound tracks. | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/shots/01-editor-timeline.png |
| `01-editor-preview.png` | 1536×688 | The preview panel alone. | The preview showing a sunset with a title on top. | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/shots/01-editor-preview.png |
| `01-editor-inspector.png` | 680×688 | The Inspector panel: zoom, position, rotation. | The Inspector with a clip's size and position. | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/shots/01-editor-inspector.png |
| `02-effects.png` | 2880×1800 | The Effects tab: transitions, colour and more. | The Effects tab with sliders for colour and blur. | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/shots/02-effects.png |
| `02-effects-panel.png` | 680×688 | The Effects tab, cropped. | The Effects tab with sliders for colour and blur. | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/shots/02-effects-panel.png |
| `03-clip-menu.png` | 2880×1800 | The right-click menu on a clip. | A clip's right-click menu with cut, copy, detach audio and more. | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/shots/03-clip-menu.png |
| `04-timeline-settings.png` | 2880×1800 | Timeline settings: shape, frame rate, in/out lock. | Timeline settings with aspect ratio and frame rate. | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/shots/04-timeline-settings.png |
| `05-title-typing.png` | 2880×1800 | A title being typed straight on the preview. | Typing a title directly on the video. | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/shots/05-title-typing.png |
| `06-help.png` | 2880×1800 | Help mode: a pop-up explaining the ruler. | A help pop-up explaining part of the timeline. | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/shots/06-help.png |
| `07-export.png` | 2880×1800 | The Export tab and its button. | The Export tab, ready to save one finished file. | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/shots/07-export.png |
| `07-export-panel.png` | 680×688 | The Export tab, cropped. | The Export tab, ready to save one finished file. | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/shots/07-export-panel.png |
| `08-look-up.png` | 2880×1800 | A link just looked up, already on the timeline as preview pictures. | A looked-up video on the timeline before it is downloaded. | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/shots/08-look-up.png |
| `08-downloads.png` | 560×980 | The Downloads list: downloading, converting, waiting, saved. | The Downloads list with progress bars. | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/shots/08-downloads.png |
| `09-walkthrough.png` | 2880×1800 | The first-run walkthrough window over the app. | The first-run walkthrough. | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/shots/09-walkthrough.png |
| `10-walkthrough-1.png` | 1280×680 | Poster for step 1. | Get a video | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/shots/10-walkthrough-1.png |
| `10-walkthrough-2.png` | 1280×680 | Poster for step 2. | Build your timeline | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/shots/10-walkthrough-2.png |
| `10-walkthrough-3.png` | 1280×680 | Poster for step 3. | Trim, cut and move | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/shots/10-walkthrough-3.png |
| `10-walkthrough-4.png` | 1280×680 | Poster for step 4. | Make it look right | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/shots/10-walkthrough-4.png |
| `10-walkthrough-5.png` | 1280×680 | Poster for step 5. | Export | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/shots/10-walkthrough-5.png |

### Walkthrough loops

1280×680, silent, seamless loops of 8 to 10.5 seconds, showing real clips. Each loop comes as WebM (VP9, smaller) and MP4 (H.264, for older browsers).

| Step | WebM | MP4 |
| --- | --- | --- |
| 1 | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/loops/walkthrough-1.webm | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/loops/walkthrough-1.mp4 |
| 2 | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/loops/walkthrough-2.webm | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/loops/walkthrough-2.mp4 |
| 3 | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/loops/walkthrough-3.webm | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/loops/walkthrough-3.mp4 |
| 4 | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/loops/walkthrough-4.webm | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/loops/walkthrough-4.mp4 |
| 5 | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/loops/walkthrough-5.webm | https://raw.githubusercontent.com/StaticMassive/toobstash-downloads/main/site/loops/walkthrough-5.mp4 |

### About what's inside the pictures

- **Walkthrough (`09`, `10-…` and the loops):** real clips from Static Massive's own channels.
- **Other screenshots (`01`–`08`):** stand-in clips, a sunset over hills and drone-flight titles such as "Bando sunset pack", made for these pictures. They don't come from any real site. The "video.example" address in them is a placeholder on purpose.

---

## 7. Build notes

- **A static site is plenty.** No server, no account system. Any framework, or none.
- **Images:**
  - Convert the PNGs to AVIF or WebP at 1× and 2× (`srcset`), and keep the PNG as a fallback.
  - Lazy-load everything below the hero.
  - Keep the hero image under about 250 KB at 1×.
- **Motion:**
  - Only the walkthrough loops play.
  - Small fades and slides as sections enter are fine.
  - Respect `prefers-reduced-motion` everywhere.
- **Accessibility:**
  - Real buttons and links.
  - Visible focus rings in the accent blue.
  - Alt text from the table in section 6.
  - Text contrast at least 4.5:1: `#8b93a3` passes only on `#14171c`.
- **Phones:**
  - Everything stacks to one column, and the walkthrough stops pinning.
  - Show screenshots cropped (the timeline, the preview) rather than shrinking a whole window until it can't be read.
- **Meta:**
  - Title: "Toob Stash: save videos and edit them, free for Mac and Windows".
  - Description: "Paste a link, download the video, and edit it in the same app: trim, stack, titles, effects, export. Free for Mac and Windows."
  - Social preview image: `01-editor.png` cropped to 1200×630, with the lockup on top.
  - Favicons: made from `icon-1024.png`.

### Before it goes live, check

- **No site names or site logos anywhere:** search every page, alt text and file name.
- **Download buttons:** both start a download and the page stays put.
- **Loops:** they pause when off screen and don't play with reduced motion.
- **Widths:** the page works at 375 px wide and at 1440 px wide.

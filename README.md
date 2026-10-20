# Trophy Disc Printer

A small web app for printing logos onto round trophy sticker sheets (25–51 mm discs on A4) so they line up with the stickers.

Everything runs in the browser. There is no server or database: logos never leave the device, and the PDF is built locally with [jsPDF](https://github.com/parallax/jsPDF).

## Features

- Sheet presets (25, 38, 44, 50 and 51 mm) plus fully editable measurements
- Several logos per sheet: upload an image or create a simple text/symbol logo
- Tap circles to choose which stickers to print, so part-used sheets can be reused
- Exact-size PDF output, printed at 100% / Actual size
- Test sheet with crosshairs and a 100 mm scale line for calibration
- Printer nudge (offset in mm), remembered per device
- Installable PWA that works offline

## Using it

1. Pick the sheet layout. Measure your real sheet and adjust under **Edit measurements** if needed.
2. Add logos and tap circles to place them.
3. **Save test sheet**, print it on plain paper at **Actual size / 100%**, and check it against a sticker sheet held up to a window.
4. Enter any offset in **Printer nudge**, then **Save stickers PDF** and print on the sticker sheet.

## Hosting

Live at **https://discs.baselinetech.ie**, served as static files from the Baseline Tech VPS
(`/var/www/trophy-disc-printer`, nginx config in `nginx-discs.conf`, certificate from certbot).
The code is on GitHub at `Jcona2025/trophy-disc-printer` as the backup and history; GitHub Pages
is not used.

To install it, open the link and choose **Add to Home screen** (phone) or the install icon in the
address bar (Chrome/Edge on a PC).

## Updating

Edit the files, bump `VERSION` in `sw.js` (e.g. `v2` → `v3`) so installed copies pick up the change,
commit, then run `./deploy.sh`. Installed copies check for updates when opened and reload.

## Files

| File | Purpose |
| --- | --- |
| `index.html` | The whole app (layout, styles and logic) |
| `jspdf.umd.min.js` | PDF library, kept locally so the app works offline |
| `manifest.webmanifest` | App name, colours and icons for installing |
| `sw.js` | Service worker: offline cache and updates |
| `icons/` | App icons |

## Ideas for later

- Photo-based calibration: photograph a printed test sheet on a sticker sheet and detect the offset with OpenCV
- Detect sheet layout from a photo (use the A4 edges as the scale reference)
- Exact presets for specific label brands

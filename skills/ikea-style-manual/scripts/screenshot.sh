#!/usr/bin/env bash
# Render an IKEA-style manual at desktop (900px) and mobile (390px) width with headless Chrome.
# Usage: bash screenshot.sh <manual.html> [out-dir]
# Then look at the PNGs and fix overflowing SVG text, collisions and empty gaps.
set -euo pipefail

html="${1:?usage: screenshot.sh <manual.html> [out-dir]}"
out="${2:-./manual-shots}"
mkdir -p "$out"

chrome=""
for c in \
  "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  "/Applications/Chromium.app/Contents/MacOS/Chromium" \
  "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge" \
  "$(command -v google-chrome 2>/dev/null || true)" \
  "$(command -v chromium 2>/dev/null || true)" \
  "$(command -v chromium-browser 2>/dev/null || true)"; do
  if [ -n "$c" ] && [ -x "$c" ]; then chrome="$c"; break; fi
done
[ -n "$chrome" ] || { echo "No Chrome/Chromium found. Open the file in a browser and check it by eye." >&2; exit 1; }

abs="$(cd "$(dirname "$html")" && pwd)/$(basename "$html")"
pages=$(grep -o 'class="page' "$abs" | wc -l | tr -d ' ')
# rough height budget per page so the full booklet fits in one shot
h_desk=$(( pages * 1150 + 400 ))
h_mob=$(( pages * 1700 + 400 ))

shoot() { # width height file
  "$chrome" --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 \
    --window-size="$1,$2" --virtual-time-budget=5000 --screenshot="$3" "file://$abs" >/dev/null 2>&1
}
shoot 900 "$h_desk" "$out/desktop.png"
# headless Chrome won't shrink its window below ~500px, so render mobile inside a 390px iframe
wrap="$out/.mobile-frame.html"
printf '<!doctype html><style>html,body{margin:0;background:#fff}iframe{border:0;width:390px;height:%spx;display:block}</style><iframe src="file://%s"></iframe>' "$h_mob" "$abs" > "$wrap"
"$chrome" --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 \
  --allow-file-access-from-files --window-size="600,$h_mob" --virtual-time-budget=5000 \
  --screenshot="$out/mobile-raw.png" "file://$(cd "$out" && pwd)/.mobile-frame.html" >/dev/null 2>&1
rm -f "$wrap"

# split into viewable slices if Python + Pillow are available
if python3 -c "import PIL" 2>/dev/null; then
  python3 - "$out" <<'PY'
import sys, os
from PIL import Image
out = sys.argv[1]
raw = os.path.join(out, "mobile-raw.png")
Image.open(raw).crop((0, 0, 390, Image.open(raw).size[1])).save(os.path.join(out, "mobile.png"))
os.remove(raw)
for name, step in (("desktop", 2400), ("mobile", 2400)):
    im = Image.open(os.path.join(out, f"{name}.png")).convert("RGB")
    w, h = im.size
    # trim trailing empty desk background
    px = im.load(); bottom = h
    while bottom > 0 and all(px[x, bottom-1] == px[0, bottom-1] for x in range(0, w, 15)):
        bottom -= 1
    for i, y in enumerate(range(0, bottom, step)):
        im.crop((0, y, w, min(bottom, y + step))).save(os.path.join(out, f"{name}-{i+1:02d}.png"))
PY
fi
ls "$out"

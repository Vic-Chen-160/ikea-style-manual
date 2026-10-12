---
name: ikea-style-manual
description: >
  Turn any how-to, workflow, onboarding, or explanation into a flat-pack furniture
  assembly manual (IKEA-style) as a single self-contained HTML file — black line-art
  figures, big step numbers, parts lists, ✓/✕ comparison panels, decision trees, and
  copy-ready command cards. Trigger when the user asks for an "IKEA-style manual",
  "assembly instructions style", "ikea-style-manual", "flatpack manual", "IKEA 說明書風格", "用 IKEA 說明書的方式",
  "做成組裝說明書", or wants a process explained "like furniture instructions".
  Also use when the user asks for a new manual "like the last one" / "照之前那份說明書".
---

# IKEA-Style Manual

Make a how-to look and read like a flat-pack furniture assembly booklet: mostly pictures,
very few words, one idea per panel, and opinionated ✓/✕ guidance. Output is **one
self-contained `.html` file** that works offline, on phones, and prints as a booklet.

The starter file `assets/template.html` already contains the full design system
(CSS tokens, every page component, and the SVG drawing kit). **Always start from it** —
copy it, keep the `<style>` and `<defs>` blocks, and replace the pages.
A finished real-world example lives in the repo at `examples/` if you need reference.

## Workflow

1. **Interrogate the topic before drawing anything.** Work out:
   - Who is assembling (the reader) and what they already know.
   - The one recommended path. Manuals don't offer five options — pick one, ✕ the rest.
   - The 3–9 physical-feeling steps. If a step can't be drawn, it's probably two steps or no step.
   - The traps: what people get wrong. These become ✕ panels.
   - Facts that might be stale (prices, limits, UI labels). Verify them with web search
     when available; otherwise list them as unverified in your final reply.
   If the request is too vague to pick a recommended path, ask one question with a
   suggested answer — not an open-ended one.

2. **Plan the booklet** as a list of pages before writing HTML. Pick from the page
   catalog below; 6–15 pages is typical. Every page answers one question.

3. **Name the product.** Every manual gets a faux-Swedish product name in caps: a real
   Swedish (or Swedish-sounding) word related to the topic — `ANVISNING` (instructions),
   `KAFFEKOPP` (coffee cup), `FLYTTA` (move), `MÖTE` (meeting). It goes on the cover
   and the back-cover footer.

4. **Build** from `assets/template.html`. Reuse the SVG symbols; draw new ones in the same
   style when needed (see Drawing kit).

5. **Self-check with screenshots** — do not skip. Run
   `bash scripts/screenshot.sh <file.html> <out-dir>` (desktop 900px + mobile 390px),
   view the PNGs, and fix: SVG text overflowing its box, labels colliding with lines or
   ✕ marks, empty gaps, panels that read as a wall of text. Re-shoot after fixing.

6. **Deliver**: save where the user asked (default: current working directory), open it,
   and reply in a few lines — what's in it, which facts are unverified, and one
   opinionated note if something in the topic deserves pushback.

## Page catalog

Use the class names exactly as in the template.

| Page | Use it for | Component |
|---|---|---|
| **Cover** | Product name, one-line description, hero drawing, badges (people needed, time) | `.page.cover` |
| **Parts list** | What you need (`1×`, `0–1×`) and what you *don't* need (crossed out) | `.parts` / `.part` / `.part.x` |
| **Two-person rule** | The right setup vs. the wrong one: sad figure alone ✕, two happy figures ✓ | `.duo` + `.panel` / `.panel.no` |
| **Overview map** | One diagram of the whole flow — the page readers come back to | `.frame` + big SVG |
| **Steps** | Big number + short heading + ≤3 sentences + framed drawing | `.step` / `.num` / `.frame` |
| **Parts bag** | A structure with lettered callouts A–F (folders, anatomy, layout) | `.legend` + `.tag` |
| **✓ / ✕ pair** | Right vs. wrong for one specific action, with real numbers | `.duo` + `.mark` |
| **Never do** | 4 classic disasters in a grid | `.quad` + `.panel.no` |
| **Decision tree** | "Where does X go?" — pill questions, boxed outcomes A/B/C | SVG in `.frame` |
| **Loop** | Recurring routines drawn as a circle of one-character verbs | SVG in `.frame` |
| **Maintenance** | Checklist with frequency pills (每月 / monthly) | `.check` + `.freq` |
| **Command cards** | Copy-ready prompts/commands with a 複製/Copy button | `.cards` / `.card` / `.copy` |
| **Back cover** | "Stuck?" — confused figure + a fill-in-the-blank help template | centered `.page` |

Not every manual needs every page. A 5-step recipe may be Cover → Parts → Steps ×2 →
✓/✕ → Back cover. A workflow/ops guide usually wants the Overview map and Command cards.

## Visual rules

- **Black on white.** `--ink #111` on `--paper #fff`, pages floating on a warm gray desk
  (`--desk`). No color except an optional single accent for a tiny highlight
  (`.copy.done`). Never imitate a real brand's logo or color scheme.
- **One line weight**: `stroke-width: 2.4`, round caps and joins, white fills. Emphasized
  outcome boxes may use 3.4. Dashed lines = optional / automatic / "flows by itself".
- **Figures, not icons.** People are the round-headed figure (`#man`); the helper (Claude,
  a colleague, a tool) is `#helper` — same figure with a small star above the head.
  Faces have only a mouth: smile `M25 20 Q30 24 35 20`, frown `M25 23 Q30 19 35 23`,
  drawn inside a nested `<svg viewBox="0 0 60 120">` so the coordinates line up.
  Add `?` marks next to a frowning figure for confusion.
- **Marks**: ✓ and ✕ sit in a circle on the panel's top-right corner (`.mark`). Wrong
  panels get the faint diagonal hatch (`.panel.no`).
- **Numbers do the talking.** Prefer "8.4 MB ✕ / 240 KB ✓" over adjectives.
- **Big step numbers** (64px, weight 900) in the left column; page numbers bottom-right;
  a small document code bottom-left (e.g. `AA-2026-10 · v1`).
- **Zoom circle**: to show a detail, draw a circle with a line back to the thing.

## Writing rules

- Match the user's language. Headings are verbs or short commands: "Compress before it
  goes in", not "About image compression".
- ≤3 sentences per step. Captions ≤2 lines. If you need more words, you need another panel.
- Be opinionated: one recommended path, and say *why* in one sentence (in a `.note`).
- Every ✕ panel names the consequence ("can't roll back", "page loads in 6 seconds").
- Command cards must be complete, paste-ready instructions with placeholders the reader
  obviously replaces (`~/Desktop/new-photos`, `Nov 8`).

## Drawing kit (in `assets/template.html` `<defs>`)

`#man`, `#helper`, `#laptop`, `#cloud`, `#vault` (safe/storage/backup), `#globe` (the
internet/public), `#photo`, `#film`, `#folder`, `#tagicon` (label/price/domain),
`#server`, `#box` (package/parcel), `#doc` (document), and marker `#arr` for arrowheads
(`marker-end="url(#arr)"`).

New symbols: draw on a small viewBox (≈60–100 units), white fill, `#111` stroke 2.4,
round joins, maximum ~6 primitives. If it needs more detail than that, simplify the idea.

## SVG gotchas (these are the bugs screenshots catch)

- SVG `<text>` does not wrap. Estimate width: CJK ≈ 1 × font-size per character, Latin
  ≈ 0.6 × font-size. Size the surrounding rect/pill from that, plus 24 units padding.
- Labels near ✕ strokes or arrows collide — move the label outside the shape.
- Keep diagram `viewBox` widths ≤ 720 and font-size ≥ 11. Diagrams 700+ wide go in
  `<div class="frame wide">` — on phones they keep a 600px minimum and scroll sideways
  inside the frame instead of shrinking to unreadable text.
- `<use href="#...">` needs explicit `width`/`height` to scale a symbol.

## Technical requirements

- Single file. Inline CSS, inline SVG, a few lines of JS only for copy buttons.
  Only external resource allowed: Google Fonts (Noto Sans TC/JP/KR for CJK). Must render
  fine without it (Verdana/system fallback).
- Responsive: grids collapse to one column under 640px; 16px side gutter; no horizontal scroll.
- Print: `@media print` already makes one page per `.page`.
- Accessibility: meaningful SVGs get `aria-label`; decorative ones `aria-hidden`.

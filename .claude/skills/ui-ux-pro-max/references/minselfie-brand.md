# Minselfie Brand Profile (Designmanual v2)

Brand override file for **Minselfie** (minselfie.no — Norwegian photobooth rental, Stavanger/Sandnes).
When a task is Minselfie-related, the tokens and rules in this file **override** whatever the
ui-ux-pro-max database returns for colors, typography, radii, motion, icons, and tone.
The database is still used for everything brand-neutral: UX guidelines, accessibility,
landing-page structure, chart advice, stack guidelines, and GSAP mechanics.

If the `minselfie-ui` skill is available in the environment, it is the authoritative, most
up-to-date source — defer to it on any conflict. This file is the self-contained fallback.

---

## Two modes, one palette

| Mode | Used for | Primary CTA |
|------|----------|-------------|
| **Calm** | Website, product pages, booking flow, FAQ | Dark navy pill |
| **Joy** | Email, thank-you screen, campaigns, social posts | Yellow pill with glow |

Never mix modes on the same surface unintentionally.

## Color tokens

```css
/* Surfaces */
--bg:           #FAF9F7;   /* page/canvas */
--bg-card:      #F3F1ED;   /* cards, secondary surface */
--bg-inverse:   #1C2130;   /* footer, dark sections */
--border:       #E3DED6;
--border-strong:#C8C1B5;

/* Text */
--ink:          #1C2130;   /* primary text + dark buttons */
--ink-soft:     #2D3146;   /* hover */
--muted:        #7A7570;   /* secondary text */
--on-dark:      #FAF9F7;
--on-dark-soft: rgba(250,249,247,0.72);

/* Accent — Calm (terracotta) */
--terracotta:       #C05C38;
--terracotta-soft:  #E8C7B8;
--terracotta-deep:  #964226;

/* Accent — Joy (yellow) */
--yellow:       #FFD074;
--yellow-soft:  #FFE7B8;
--yellow-deep:  #C99230;

/* Functional */
--link:  var(--terracotta);
--focus: rgba(192,92,56,0.18);

/* Shadows */
--shadow-sm: 0 1px 2px rgba(28,33,48,0.04);
--shadow:    0 4px 16px rgba(28,33,48,0.06);
--shadow-md: 0 8px 24px rgba(28,33,48,0.08);
--shadow-lg: 0 24px 48px rgba(28,33,48,0.10);
--shadow-yellow: 0 4px 14px rgba(255,208,116,0.35);
```

Joy-mode surfaces (not in `:root`): `#FBF4EC` warm cream (email/thank-you background),
`#FDE9DE` peach (Joy content boxes).

Hard rules: never cold gray-on-gray; never blue-purple gradients or mesh backgrounds;
yellow is an accent, not a surface; confetti/glitter only as prop still-images, never
as a page background.

## Typography

Two families only — never Inter, never Roboto:

| Family | Role | Weights |
|--------|------|---------|
| **Fraunces** (variable serif) | Display, H1–H3, price figures | 400–800 |
| **DM Sans** | Body, UI, buttons, eyebrow | 400–700 |

```css
--font-display: "Fraunces", "Georgia", serif;
--font-sans:    "DM Sans", system-ui, sans-serif;

--display-1: clamp(40px, 5.5vw, 76px) / 1.04, weight 700, track -0.025em
--h1: clamp(32px, 4vw, 52px) / 1.08, weight 700, track -0.02em
--h2: clamp(26px, 2.8vw, 36px) / 1.15, weight 700, track -0.015em
--h3: 22px / 1.25, weight 600, track -0.01em
--body-lg: 18px / 1.6   --body: 15px / 1.6   --body-sm: 13px / 1.55
/* Eyebrow: 11px · 600 · uppercase · letter-spacing 0.12em · color --muted */
```

Fraunces only on headings and price figures; DM Sans on everything else.
`text-wrap: balance` on all headings, `text-wrap: pretty` on body paragraphs.

## Spacing (4px grid), radii, motion, icons

```
--s-1: 4px  --s-2: 8px  --s-3: 12px  --s-4: 16px  --s-5: 24px
--s-6: 32px --s-7: 48px --s-8: 64px  --s-9: 96px  --s-10: 128px
```
Section spacing: s-7 to s-10. Component-internal: s-2 to s-5.

```
--radius-sm: 8px (inputs, badges)   --radius: 12px (default)
--radius-md: 16px   --radius-lg: 20px (cards)   --radius-xl: 24px (large cards, modals)
--radius-pill: 100px (buttons — the signature!)
```
Buttons are ALWAYS full pill (radius-pill). Never sharp 0px containers.

```css
--ease:   cubic-bezier(.2,.8,.2,1);
--t-fast: 160ms;  /* focus ring, border-color */
--t-base: 240ms;  /* button/card hover */
--t-slow: 420ms;  /* modals, page transitions */
```

Icons: **Lucide, always 1.75px stroke.** Never filled icons, never other stroke widths.
Sizes: 16px inline, 20px UI, 24px standalone.

## Components

**Buttons** (base: DM Sans 15px/600, padding 12px 22px, radius 100px,
`transition: all var(--t-base) var(--ease)`; `.btn-sm` 13px/8px 16px, `.btn-lg` 16px/16px 28px):

- Primary Calm: `#1C2130` on `#FAF9F7` text, hover `#2D3146` + translateY(-1px) + shadow-md
- Primary Joy: `#FFD074` bg, `#1C2130` text, `--shadow-yellow`
- Accent: `#C05C38` bg, white text, hover `#964226`
- Secondary ghost: transparent, 1px `--border-strong` border
- Link style: plain text + arrow

**Pills/badges** (12px/600, padding 5px 12px, radius 999px): `pill-yellow` (yellow/ink),
`pill-coral` (terracotta-soft/terracotta-deep), `pill-dark` (ink/on-dark), `pill-soft`
(bg-card/ink), `pill-outline` with optional status dot.

**Form fields:** padding 12px 14px, radius 12px, 1px `--border-strong` border, white bg,
DM Sans 14px. Focus: terracotta border + `0 0 0 4px var(--focus)` ring, no outline.
Error: border `#B23A2A` + 12px message below, no red focus ring.

**Cards:** white bg, radius 24px, padding 28px, shadow-md, hover lift
(`translateY(-2px)` + shadow-lg). Cream (`--bg-card`) and dark (`#1C2130`) variants have
no shadow and no hover lift.

**Logo** (`<circle r="7">` dot + Fraunces 700 "Minselfie"): light surface → dot `#C05C38` /
text `#1C2130`; dark surface → dot `#FFD074` / text `#FAF9F7`; yellow surface → both `#1C2130`.

## Email (Joy mode)

600px single column, mobile-first. White body on warm beige (`#FAF9F7`) frame; peach
(`#FDE9DE`) or cream (`#FBF4EC`) content boxes; terracotta headings with exactly **one**
emoji; yellow pill CTA with glow (`0 3px 10px rgba(255,208,116,0.45)`); character
illustration (SVG box/package) above the title; friendly terracotta greeting. Never a gray
banner header, never inconsistent CTA shapes.

## Imagery

Product photos: white/light background, the booth as the hero, no overlays. People photos:
warm daylight, real people in a moment, props. Never: stock models, black & white,
gradient overlays, pattern textures. Use full-bleed images as "punctuation" between
text-heavy sections.

## Tone & copy (Norwegian)

Always: «du»-form; concrete numbers (5 minutter, 2 490 kr, 30 sekunder); short sentences;
comma/period over dashes; quiet confidence, no bragging.
Never: ALL CAPS shouting, exclamation-mark spam, corporate speak («løsning»,
«kundeopplevelse», «synergier», «intuitivt»), mentioning competitors.
Prices are written `fra 2 490 kr inkl. mva` — always inkl. mva, never «kr 2490,-».

## Elementor implementation notes

Global colors exist in Elementor as "MS [name]" (MS Bakgrunn #FAF9F7, MS Krem #F3F1ED,
MS Fersken #FDE9DE, MS Mørk #1C2130, MS Border #E3DED6, MS Border strong #C8C1B5,
MS Muted #7A7570, MS Terrakotta #C05C38, MS Terrakotta soft #E8C7B8, MS Terrakotta deep
#964226, MS Gul #FFD074, MS Gul soft #FFE7B8, MS Gul deep #C99230). Global fonts:
Primary/Secondary = Fraunces 700 (52/36px desktop), Text = DM Sans 400 15px,
Accent = DM Sans 600 13px / 0.12em. Use Containers (Flexbox), Custom CSS via
Advanced → Custom CSS with `selector` prefix, max content width 1100px centered,
Google Fonts loaded via Code Snippets in `<head>`.

## Pre-delivery brand checklist

Tone: du-form; concrete numbers; no stray exclamation marks; price as «fra X kr inkl. mva»;
dashes replaced with comma/period; corporate speak removed.
Visual: all buttons pill-shaped; correct mode (Calm vs Joy); Fraunces headings + DM Sans
body; colors from tokens only (#FAF9F7, #1C2130, #C05C38, #FFD074); generous whitespace
(s-7–s-10 between sections); no cold gray-on-gray, no blue-purple gradients; correct logo
variant for the surface.

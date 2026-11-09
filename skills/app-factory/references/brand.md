# Brand & ASO (approved SPEC → name, brand kit, keywords)

Goal: every app ships with a name people search for and a brand a stranger trusts enough to pay for, carried through the app, the store page and the website. Target: right after G1, days 2-3, about 1.5 days. Sign-offs S1 and S2.

Claude proposes; the user picks and signs off. The user never designs by hand. Visual options live on a Claude Design artifact (canvas) the user reviews and comments on. Figma is an optional upgrade, not required.

## Tools

| Need | Tool |
| --- | --- |
| Keyword research, store copy knowledge | apple-skills app-store (keyword-optimizer, knowledge only) + WebSearch |
| Brand board, logo/wordmark, icon and screen mockups | Claude Design artifact (canvas): `Artifact` quickstart with intent `design`, one artboard per direction plus core-loop screens. Optional: Figma MCP (`figma@claude-plugins-official`) if the user has a plan |
| Icon, logo, splash, illustrations, paywall hero, onboarding art | Hand-written SVG, exported to PNG with `npx -y @resvg/resvg-js-cli in.svg out.png` (needs one-time user approval of the run). Optional: an image-generation MCP for raster art, if one is connected (see `references/setup.md`); never stop the step because none is |
| What to avoid | `vendor/mobile-taste/skills/_shared/references/tells.md` (AI-slop tells apply to brands too) |

## Steps

1. **Keywords (ASO).** From SPEC §3-§4 and §10: what people search for in this category, what the top competitors rank for (their names, subtitles and descriptions), and Apple Search Ads popularity where available. Free sources first; a paid tool only if `app-factory.config.json` `marketData.tool` names one. Write primary and secondary terms to `docs/BRAND.md` §Keywords. Never use competitor names or trademarks as keywords (App Store guideline 2.3.7).
2. **Names.** 3-5 candidates that carry the primary keyword where it reads naturally. For each: App Store and Play search for clashes, a trademark search (record the source and result), and a free `<webBaseUrl>/<slug>` path. Rank them. **S1: the user picks one.** Record in BRAND.md §Name and STATUS.
3. **Directions.** 2-3 brand directions on one artifact canvas (if `app-factory.config.json` `figma.templateFileUrl` is set and the Figma MCP is connected, a Figma board is allowed instead). Each direction: light and dark palette, type pairing, a logo or wordmark, an icon concept as SVG, 2-3 sample screens of the core loop. Check each against `tells.md` before showing it. Publish privately and give the user the link; sharing is the user's action. **S2: the user picks one by commenting on the artifact.** Record the artifact (or Figma) link in BRAND.md §Review board and the decision in STATUS.
4. **Brand kit** from the chosen direction:
   - **Tokens:** semantic colors (light/dark), type scale, radius, spacing. The source of truth is `src/theme/` in the app (with Figma, mirror them as variables).
   - **Icon:** author as SVG, export with resvg: iOS light, dark and tinted 1024×1024 PNGs (Expo `ios.icon` object, no Mac needed); Android adaptive foreground, background and monochrome; Play 512×512. Keep the SVG sources in `assets/brand/src/`.
   - **Splash:** image and background color for light and dark.
   - **Image style:** write the SVG style rules (shapes, stroke, palette, corner radius) in BRAND.md. If an image MCP is connected, also save 3-5 reference images in `assets/brand/style/` and generate later images with them as references.
   - **In-app imagery:** onboarding art, empty states, paywall hero (also used in the RevenueCat paywall), as SVG unless raster art is needed and an image MCP is connected. If a provider is used, check its terms allow commercial use and note it in BRAND.md.
5. **Record** everything in `docs/BRAND.md` (from `templates/BRAND.md`), including image spend if any. Update the app's tokens and assets in Phase 2 and M05.

## Rules

- Stay inside the 1.5-day budget. If S1 isn't picked by the end of day 2, propose showing 2 directions instead of 3 and fewer in-app images. If S2 isn't signed off by the end of day 3, propose concrete cuts to the kit (for example defer in-app imagery to M05). Note either in STATUS.
- Brand work never changes the stack contract or styling rules (StyleSheet + tokens).
- Phase 2 screen design starts only after S2. If asked earlier, say S1/S2 are open and ask whether to finish them first.

## Sign-offs

- **S1 Name:** a name is picked after store and trademark checks.
- **S2 Direction:** a direction is picked on the review board (artifact or Figma) and the kit is in BRAND.md.

S3 (store set) happens in Phase 6.

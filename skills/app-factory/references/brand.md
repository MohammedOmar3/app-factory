# Brand & ASO (approved SPEC → name, brand kit, keywords)

Goal: every app ships with a name people search for and a brand a stranger trusts enough to pay for, carried through the app, the store page and the website. Target: right after G1, days 2-3, about 1.5 days. Sign-offs S1 and S2.

Claude proposes; the user picks and signs off. The user never designs by hand. Visual options live on a Figma board the user reviews.

## Tools

| Need | Tool |
| --- | --- |
| Keyword research, store copy knowledge | apple-skills app-store (keyword-optimizer, knowledge only) + WebSearch |
| Brand board, logo/wordmark, icon and screen mockups | Figma MCP (`figma@claude-plugins-official`, remote server, writes to the canvas) |
| Images (icon artwork, illustrations, paywall hero, onboarding art) | The `nanobanana` image-generation MCP (install line in `references/setup.md`, needs `GEMINI_API_KEY`); if it is not connected, stop at the image steps and tell the user |
| What to avoid | `vendor/mobile-taste/skills/_shared/references/tells.md` (AI-slop tells apply to brands too) |

## Steps

1. **Keywords (ASO).** From SPEC §3-§4 and §10: what people search for in this category, what the top competitors rank for (their names, subtitles and descriptions), and Apple Search Ads popularity where available. Free sources first; a paid tool only if `app-factory.config.json` `marketData.tool` names one. Write primary and secondary terms to `docs/BRAND.md` §Keywords. Never use competitor names or trademarks as keywords (App Store guideline 2.3.7).
2. **Names.** 3-5 candidates that carry the primary keyword where it reads naturally. For each: App Store and Play search for clashes, a trademark search (record the source and result), and a free `<webBaseUrl>/<slug>` path. Rank them. **S1: the user picks one.** Record in BRAND.md §Name and STATUS.
3. **Directions.** 2-3 brand directions on a Figma board (start from `app-factory.config.json` `figma.templateFileUrl` when set, otherwise create a new file). Each direction: light and dark palette, type pairing, a logo or wordmark, an icon concept, 2-3 sample screens of the core loop. Check each against `tells.md` before showing it. **S2: the user picks one in Figma.** Record the Figma link in BRAND.md §Figma and the decision in STATUS.
4. **Brand kit** from the chosen direction:
   - **Tokens:** semantic colors (light/dark), type scale, radius, spacing. The source of truth is `src/theme/` in the app; mirror them as Figma variables so the board stays in sync.
   - **Icon:** iOS light, dark and tinted 1024×1024 PNGs (Expo `ios.icon` object, no Mac needed); Android adaptive foreground, background and monochrome; Play 512×512.
   - **Splash:** image and background color for light and dark.
   - **Image style:** 3-5 reference images saved in `assets/brand/style/`; every later image is generated with them as references so the app looks consistent.
   - **In-app imagery:** onboarding art, empty states, paywall hero (also used in the RevenueCat paywall). Check the image provider's terms allow commercial use and note it in BRAND.md.
5. **Record** everything in `docs/BRAND.md` (from `templates/BRAND.md`), including image spend. Update the app's tokens and assets in Phase 2 and M05.

## Rules

- Stay inside the 1.5-day budget. If S1 isn't picked by the end of day 2, propose showing 2 directions instead of 3 and fewer generated images. If S2 isn't signed off by the end of day 3, propose concrete cuts to the kit (for example defer in-app imagery to M05). Note either in STATUS.
- Brand work never changes the stack contract or styling rules (StyleSheet + tokens).
- Phase 2 screen design starts only after S2. If asked earlier, say S1/S2 are open and ask whether to finish them first.

## Sign-offs

- **S1 Name:** a name is picked after store and trademark checks.
- **S2 Direction:** a direction is picked in Figma and the kit is in BRAND.md.

S3 (store set) happens in Phase 6.

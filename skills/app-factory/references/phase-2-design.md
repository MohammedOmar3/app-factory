# Phase 2: Design (SPEC.md → approved UX.md + clickable prototype)

Goal: every screen, flow, state and string decided before feature code, and approved on the real phone. Target: day 3 (G2 on day 4). Gate G2.

## Skills used

| Need | Skill |
| --- | --- |
| Screen inventory, flows, states | apple-skills product UX spec (knowledge only; output into UX.md, never SwiftUI) |
| Tokens: color, spacing, type, radius, motion | expo-design-system |
| Native look and controls | expo-native-ui, expo-ui (universal components first) |
| Navigation structure | expo-router (native tabs, stacks, modals, sheets) |
| Motion and haptics | expo-animation |
| Copy: buttons, empty states, errors, paywall | apple-skills design/ux-writing |
| Divergent options | superpowers:brainstorming (2-3 directions, pick one) |
| What to avoid | `vendor/mobile-taste/skills/_shared/references/tells.md` (AI-slop tells catalog) |
| Template screen patterns | `vendor/mobile-taste/skills/_shared/blocks/` (value-first onboarding, honest paywall, minimal auth, grouped settings, composed empty states) |
| Design review | `vendor/mobile-taste/skills/mobile-design-review/REVIEW.md` with its rubric (overrides in SKILL.md) |

## Steps

1. **Brand.** Read `docs/BRAND.md`. The direction was chosen at S2 in the brand step (`references/brand.md`); don't propose new directions. If S2 isn't signed off, stop and ask whether to finish the brand step first. Keep `tells.md` in mind while designing screens.
2. **Tokens.** With expo-design-system, write the brand kit's tokens into `src/theme/` (semantic colors for light/dark, spacing scale, type scale that respects Dynamic Type / font scale, radius, motion durations). `src/theme/` is the source of truth; mirror changes back to the Figma variables. Record them in UX.md §Tokens.
3. **Navigation map.** Routes in `app/`: which are tabs, stacks, modals, sheets. Keep template routes (onboarding, paywall, settings/account).
4. **Screen specs.** For each SPEC screen, in UX.md: purpose, primary action, layout sketch (ASCII wireframe), components, and **all states**: loading, empty, error, offline, anonymous vs signed-in, free vs `pro`.
5. **Template flows, tailored** (start from the matching mobile-taste block, translated to StyleSheet + tokens):
   - Onboarding: max 3 screens, show value before any sign-in (anonymous user already exists). Ask for permissions only at the moment of use, with a priming line.
   - Paywall: one slot in onboarding right after the first value moment, and one where a `pro` feature is tapped; never on launch. Price, period, what `pro` unlocks, the trial or intro offer with its terms, Restore, Terms and Privacy links. Win-back and cancellation offers come from RevenueCat Customer Center. Use the RevenueCat paywall with the brand kit's paywall hero, styled with the tokens. No fake timers, hidden close buttons or misleading prices.
   - Rating prompt: after a success moment in the core loop, rate-limited (the template's rating helper decides when; never after an error or on first launch).
   - Push permission: asked when the user wants a reminder or update, after a priming line that says what they'll get; never on launch.
   - Account: sign-in options (Apple first on iOS), restore purchases, delete account, support link.
6. **Copy.** Every user-facing string in UX.md §Copy, written with ux-writing guidance: verbs on buttons, errors that say what to do next, no "Oops". Strings go into the template's i18n files (English first; other app languages per SPEC). Layouts are RTL-safe: use start/end, never left/right, so Arabic works when enabled.
7. **Clickable prototype.** On a branch `design/prototype`, build the screens with static mock data and real navigation (no Supabase, no purchases). Push; the preview update lets the user tap through on the iPhone. This replaces mockup tools: the user reviews the real thing on the real device.

## Design review (run before G2, write findings into UX.md §Review)

Run the vendored mobile-design-review in **report-only** mode on the prototype branch:

- Static pass: its tells grep checklist and ten-category rubric against the code.
- Live pass: there is no iOS Simulator on Windows, so use (in order) the Android emulator via expo-mcp on the PC, or screenshots the user takes on the iPhone from the preview update. Ask for the screenshots by screen name.
- Record the Design Score and AI Slop Score, write `docs/design-baseline.json`, and list findings by impact. High-impact findings are fixed before G2.

Then check these items it may not cover:

- Thumb reach: primary actions in the bottom half; nothing important behind small top-corner targets.
- Touch targets ≥ 44 pt; contrast ≥ 4.5:1 for text (check both themes).
- Largest accessibility font size doesn't break layouts; screen-reader labels on icons.
- Platform feel: native tabs/stacks, iOS swipe-back works, Android back button works.
- Every state from step 4 is reachable in the prototype (add a debug toggle).
- First-run: value is visible within 60 seconds without signing in.

## Gate G2

User taps through the prototype on the phone and approves (or lists changes). Record in STATUS.md. The prototype branch's screens become the starting point for Phase 4; don't throw them away.

Output: `docs/UX.md` (from `templates/UX.md`, including §Moments), `src/theme/`, `design/prototype` branch.

# Phase 2: Design (SPEC.md → approved UX.md + clickable prototype)

Goal: every screen, flow, state and string decided before feature code, and approved on the real phone. Target: day 2-3. Gate G2.

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

1. **Direction.** Read `tells.md` first. Propose 2-3 visual directions in words (mood, palette family, type, density), each with one reference app, and check each against the tells (no default indigo gradients, white card stacks, five tabs plus a floating button, emoji as icons). User picks one. Respect both light and dark mode.
2. **Tokens.** With expo-design-system, write `src/theme/` tokens (semantic colors for light/dark, spacing scale, type scale that respects Dynamic Type / font scale, radius, motion durations). Record them in UX.md §Tokens.
3. **Navigation map.** Routes in `app/`: which are tabs, stacks, modals, sheets. Keep template routes (onboarding, paywall, settings/account).
4. **Screen specs.** For each SPEC screen, in UX.md: purpose, primary action, layout sketch (ASCII wireframe), components, and **all states**: loading, empty, error, offline, anonymous vs signed-in, free vs `pro`.
5. **Template flows, tailored** (start from the matching mobile-taste block, translated to StyleSheet + tokens):
   - Onboarding: max 3 screens, show value before any sign-in (anonymous user already exists). Ask for permissions only at the moment of use, with a priming line.
   - Paywall: shown after the first value moment, not on launch. Price, period, what `pro` unlocks, Restore, Terms and Privacy links. Use RevenueCat paywall; style it with the tokens.
   - Account: sign-in options (Apple first on iOS), restore purchases, delete account, support link.
6. **Copy.** Every user-facing string in UX.md §Copy, written with ux-writing guidance: verbs on buttons, errors that say what to do next, no "Oops". Store strings in one file so later localization is easy.
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

Output: `docs/UX.md` (from `templates/UX.md`), `src/theme/`, `design/prototype` branch.

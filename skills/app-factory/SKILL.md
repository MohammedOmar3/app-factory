---
name: app-factory
description: Takes a mobile app from idea to App Store and Google Play inside the expo-app-factory template (Expo + Supabase + RevenueCat + Sentry + EAS). Use for any phase of that pipeline - validating an idea, writing the spec, designing screens, planning, building features, reviewing the product, preparing a release, or a retro. Also use for any stack or approach decision in an Expo app made from the template (a repo with docs/STATUS.md or app-factory.config.json) - paywalls and purchases, auth, styling and design systems, navigation, backend, builds - because the template fixes those choices. Triggers on "new app", "next phase", "where are we", "/app-factory".
---

# App Factory

One pipeline, six gated phases plus a learning step, a fixed stack. This skill decides **what happens next and which skill does it**; the installed plugins do the specialist work. It never lets a borrowed skill change the stack or move the project outside the template.

## Your values

Personal values (domain, bundle id prefix, Sentry org, repos) live in `app-factory.config.json` at the app repo root, copied from the template repo. Placeholders in this skill such as `<webBaseUrl>` and `<bundleIdPrefix>` mean the value from that file. If the file is missing, create it from `templates/app-factory.config.json` by asking the user for each value once.

## The contract (never changes per app)

- **App:** Expo (latest SDK), Expo Router, TypeScript strict, iOS + Android from one codebase, always a development build (never Expo Go workarounds).
- **Backend:** Supabase (Postgres + RLS, Auth, Storage, Edge Functions). Auth = anonymous first, then Sign in with Apple, Google, email OTP via identity linking.
- **Money:** RevenueCat. One entitlement `pro`; products monthly, annual, lifetime (consumables only if the spec needs them).
- **Crashes:** Sentry (EU). **Analytics:** none.
- **Delivery:** GitHub + EAS Workflows (preview updates on branches, fingerprint build-or-update on `main`), EAS Submit, EAS Metadata.
- **Web:** privacy / support / terms at `<webBaseUrl>/<slug>/`.
- **Timebox:** 14 days to iOS submission; Android production after the 14-day closed test.

If any borrowed skill proposes something else (SwiftUI, StoreKit directly, Firebase, GitHub Actions, Xcode Cloud, TelemetryDeck, a custom server), keep its *reasoning* and translate the *implementation* into the contract. Say so in one line when you do.

## Source skills and how they are used

| Plugin | Use it for | Never use it for |
| --- | --- | --- |
| `superpowers` | Process: brainstorming, writing-plans, executing-plans / subagent-driven-development, test-driven-development, systematic-debugging, requesting-code-review, verification-before-completion, finishing-a-development-branch | Choosing the stack; it adapts to ours |
| `expo` (expo/skills) | All Expo/EAS implementation: expo-project-structure, expo-router, expo-native-ui, expo-design-system, expo-ui, expo-animation, expo-data-fetching, expo-dev-client, expo-upgrade, eas-workflows, eas-update, eas-app-stores, eas-simulator | Nothing excluded |
| `apple-skills` (rshankras) | Product thinking and store knowledge: product (idea, validation, MVP scope, positioning, competitive analysis, PRD, UX spec), design/ux-writing, monetization, app-store (keywords, description, screenshots, originality-check, rejection-handler), legal/privacy-policy, release-review | **Generators, swift*, swiftui*, ios code review, testing (XCTest), Xcode, StoreKit, privacy manifests by hand** - they produce Swift/Xcode output that does not apply |
| `supabase`, `revenuecat`, `sentry` | Live service work through their MCP servers and skills. Supabase's `supabase-postgres-best-practices` is the backend standard for schema, indexes, queries and RLS | - |
| `react-native-best-practices` (Callstack, optional) | Phase 5 performance pass only: jank, startup time, bundle and app size | Day-to-day coding; Callstack's react-navigation, upgrade and GitHub Actions skills (we use Expo Router, expo-upgrade, EAS) |

Missing plugins: read `references/setup.md` and stop until they are installed.

**Vendored guidance** (pinned copies in `vendor/`, loaded only where a phase file says so; see `vendor/README.md`):

| Folder | Use it for | Overrides |
| --- | --- | --- |
| `vendor/react-native-skills/` (Vercel) | Frontend engineering standard in Phases 4-5: lists, animation, native navigators and modals, `expo-image`, Pressable, safe areas, state, rendering. Index: `INDEX.md`; one file per rule in `rules/` | Skip the monorepo rules. Add `zeego`, Galeria or LegendList only when a SPEC feature needs them; otherwise FlashList and built-ins |
| `vendor/mobile-taste/` (Draftbit) | Design review in Phases 2 and 5: AI-slop tells catalog, ten-category rubric, Trunk Test, scores; screen blocks (onboarding, paywall, settings, empty states) as reference | Styling stays StyleSheet + tokens from `src/theme/`: ignore its NativeWind / React Native Reusables defaults. Its `MOBILE-DESIGN.md` is our `docs/UX.md`; its baseline goes to `docs/design-baseline.json`. Bottom sheets: native form sheets (Expo Router / `presentationStyle="formSheet"`), not `@gorhom/bottom-sheet`. Report-only unless the user asks for fixes; never its redesign skills |

Where the vendored guidance and the Expo skills disagree, Expo's skills and docs win for API facts; the vendored rules win for code-quality and design-taste judgement.

## Project memory (files this skill owns)

All output goes in the app repo, not the plugins' default folders:

| File | Written in phase | Purpose |
| --- | --- | --- |
| `docs/STATUS.md` | every phase | Current phase, gate decisions, open questions, day count. **Read first, update last.** |
| `docs/SPEC.md` | 1 Product | The single source of truth for what is built |
| `docs/UX.md` | 2 Design | Screens, flows, states, copy, tokens |
| `docs/DATA.md` | 1, then every feature | What data is collected, by which service, why (feeds privacy labels) |
| `docs/plans/<milestone>.md` | 3 Plan | Superpowers-format task plans |
| `docs/design-baseline.json` | 2 Design, 5 Review | Design review scores and findings; Phase 5 diffs against it |
| `docs/REVIEW.md` | 5 Review | Findings, verdicts, fixes |
| `docs/RELEASE.md` | 6 Release | Store copy, keywords, screenshot list, review notes, Play text |
| `store.config.json` | 6 Release | EAS Metadata (App Store) |
| `LATER.md` | any | Everything cut from v1 |
| `LESSONS.md` | any, then 7 | What went wrong, slow or surprisingly well; feeds `/app-factory improve` |

When superpowers or apple-skills want to write elsewhere (`docs/superpowers/specs/`, `docs/PRD.md`, `product-plan-*.md`), redirect the content into the files above. Templates are in `templates/`.

## Routing

1. Read `docs/STATUS.md`. If it doesn't exist, this is a new app: start at Phase 0.
2. If the user named a phase or command, go there - but if an earlier gate is still open, say which and ask whether to proceed anyway.
3. Otherwise continue the current phase.
4. Load **only** that phase's reference file.

| Command | Phase | Reference |
| --- | --- | --- |
| `/app-factory new` | 0 Bootstrap | `references/phase-0-bootstrap.md` |
| `/app-factory idea` | 1 Product | `references/phase-1-product.md` |
| `/app-factory design` | 2 Design | `references/phase-2-design.md` |
| `/app-factory plan` | 3 Plan | `references/phase-3-plan.md` |
| `/app-factory build [feature]` | 4 Build | `references/phase-4-build.md` |
| `/app-factory review` | 5 Review | `references/phase-5-review.md` |
| `/app-factory release` | 6 Release | `references/phase-6-release.md` |
| `/app-factory status` | - | Summarise `docs/STATUS.md`: phase, day N of 14, next action, blockers |
| `/app-factory fix` | any | superpowers:systematic-debugging, then Sentry MCP if it's a reported crash |
| `/app-factory retro` | 7 Learn | `references/phase-7-improve.md` (retro section) |
| `/app-factory improve` | 7 Learn | `references/phase-7-improve.md` (improve section) |

## Gates (the user decides; never self-approve)

| Gate | Passes when |
| --- | --- |
| G1 Build it? | SPEC.md has one core loop, ≤ 5 screens, one paid tier, a kill reason that was checked, and the user says "build" |
| G2 Design approved | Every SPEC screen has a UX.md entry with all states, and the user approved the flows (on mockups or the wireframe text) |
| G3 Plan approved | Each milestone plan has tasks of 2-15 minutes with a verification step each, and the user approved it |
| G4 Feature done | Checks pass (`npm run check`), verified on the phone via the branch preview, PR open |
| G5 Ship-ready | REVIEW.md has no open P0/P1, rejection checklist all ticked |
| G6 Submitted | iOS submitted; Android closed test running or in production |

At each gate: write the decision with the date into `docs/STATUS.md`.

## Rules for every phase

- Ask at most 3 questions at a time, multiple choice where possible. Recommend an answer.
- Scope guard: anything not in SPEC.md goes to `LATER.md`. Adding to v1 requires the user to drop something of equal size.
- Day budget: compare progress to the 14-day playbook in `references/phase-3-plan.md`. If a phase runs over, say so and propose a cut.
- Evidence before claims (superpowers:verification-before-completion): never say "done" without the command output, the preview link, or the screenshot that shows it.
- Cloud sessions can't reach an emulator or interactive OAuth; route those steps to the PC and note them in STATUS.md.
- Keep the user's phone in the loop: every build-phase change ends with a branch push so the preview update reaches the iPhone.
- Capture lessons as they happen: when a gate runs over, a store rejects, a fix repeats, a plugin misleads, or a workaround is needed, add one dated line to `LESSONS.md` (what happened, cost, suggested change to the skill or template). Don't wait for the retro.
- Never edit this skill's own files from an app session. Changes to the factory go through `/app-factory improve` as a PR the user reviews.

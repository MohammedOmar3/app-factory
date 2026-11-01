# Phase 3: Plan (SPEC + UX → milestone plans)

Goal: the build broken into small, verifiable tasks the user approved. Target: day 4. Gate G3.

## Skill

`superpowers:writing-plans`, with these overrides:

- Save plans to `docs/plans/<nn>-<milestone>.md`, not `docs/superpowers/plans/`.
- Every task names exact files, the change, and a **verification** that fits this stack (table below).
- Tasks are 2-15 minutes. A task that touches the database, a store, or a paid service says so in its title.
- Each milestone ends with "push branch, open PR, verify on phone via preview update".

## Verification by kind of task

| Task touches | Verify with |
| --- | --- |
| Pure TypeScript logic (dates, scoring, parsing) | Jest test first (superpowers:test-driven-development) |
| Database schema / RLS | SQL through Supabase MCP: as user A can't read user B's row; anonymous restrictions hold; advisors clean |
| Edge Function | Invoke it with a test JWT; check the row it wrote |
| UI screen | `npm run check`, then on the iPhone via preview update; screenshot or the user's confirmation |
| Purchases | Sandbox purchase on device; RevenueCat customer shows `pro`; `entitlements` row exists |
| Native dependency added | `development.yml` workflow run succeeds (the first iOS dev build of an app runs interactively in the user's terminal); app opens on phone |
| Push notification | A test push from the send function reaches the user's device |
| Events | After a test run, the funnel steps appear as events (EAS Observe or the Supabase events table) |
| Localised strings | The app in Arabic shows a right-to-left layout without clipping |
| Workflow / EAS config | `eas workflow:run` succeeds; link to the run |

Don't write UI snapshot tests or E2E suites for v1; device review is the UI test.

## Milestones (default; adjust to SPEC)

| # | Milestone | Ends by | Includes |
| --- | --- | --- | --- |
| 01 | Data + auth for this app | Day 5 | Tables, RLS, types, sign-in options wired, account deletion verified |
| 02 | Core loop | Day 6 | The SPEC core loop end to end on real data; merge → first TestFlight + Play internal build |
| 03 | Remaining features | Day 8 | Other SPEC screens, all UX states |
| 04 | Monetization | Day 9 | Products (RevenueCat MCP, all territories except SPEC §11), trial or intro offer, onboarding and feature paywall slots, gating client + server, restore, Customer Center win-back, a RevenueCat Experiment set up (not started), Paddle web product mapped to `pro` |
| 05 | Polish | Day 10 | Brand kit applied (icon variants, splash, in-app imagery), rating prompt and push moments from UX.md §Moments, haptics, accessibility, offline/error states, Sentry triage of TestFlight crashes |
| 06 | Store assets | Day 12 | Phase 6 steps 1-7 (copy, screenshots, video, assets, privacy answers, web deploy, S3) |
| 07 | Release | Day 12 | Phase 6 submission |

## The 14-day budget

| Day | Phase / milestone |
| --- | --- |
| 1 | Phase 1 Product (with G1 revenue analysis and legal screen) |
| 2 | Phase 0 finish; Brand & ASO: keywords, names (S1) |
| 3 | Brand directions (S2) and kit; Phase 2 Design |
| 4 | Design approval (G2), Phase 3 Plan (G3) |
| 5-6 | M01, M02; day 5 first TestFlight build; Play closed test starts if Play exists |
| 7-8 | M03 |
| 9 | M04 |
| 10 | M05 |
| 11 | Phase 5 Review including compliance; store assets start |
| 12 | Store assets (S3), Phase 6, iOS submitted |
| 13-14 | Review buffer, fixes |
| outside the 14 days | Play production after the 14-day closed test with 12+ testers |

Compare actual progress to this table at every gate and sign-off and in `/app-factory status`. If more than one day behind, propose specific cuts from SPEC.md §5 (move to LATER.md). If S1 isn't picked by the end of day 2, propose showing 2 directions instead of 3 and fewer generated images. If S2 isn't signed off by the end of day 3, propose concrete cuts to the kit (for example defer in-app imagery to M05). Note either in STATUS.

## Gate G3

Show the milestone list with task counts and any task that needs the user (store consoles, device, payments). User approves. Record in STATUS.md.

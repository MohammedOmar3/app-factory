# Phase 3: Plan (SPEC + UX → milestone plans)

Goal: the build broken into small, verifiable tasks the user approved. Target: day 3. Gate G3.

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
| Native dependency added | `dev-build.yml` run succeeds; app opens on phone |
| Workflow / EAS config | `eas workflow:run` succeeds; link to the run |

Don't write UI snapshot tests or E2E suites for v1; device review is the UI test.

## Milestones (default; adjust to SPEC)

| # | Milestone | Ends by | Includes |
| --- | --- | --- | --- |
| 01 | Data + auth for this app | Day 4 | Tables, RLS, types, sign-in options wired, account deletion verified |
| 02 | Core loop | Day 5 | The SPEC core loop end to end on real data; merge → first TestFlight + Play internal build |
| 03 | Remaining features | Day 8 | Other SPEC screens, all UX states |
| 04 | Monetization | Day 9 | Products (RevenueCat MCP), paywall, gating client + server, restore |
| 05 | Polish | Day 10 | Icon, splash, haptics, accessibility, offline/error states, Sentry triage of TestFlight crashes |
| 06 | Release | Day 12 | Phase 6 tasks |

## The 14-day budget

| Day | Phase / milestone |
| --- | --- |
| 1 | Phase 1 Product (+ Phase 0 starts) |
| 2 | Phase 0 finish, Phase 2 Design |
| 3 | Design approval, Phase 3 Plan |
| 4-5 | M01, M02; day 5 first store builds; Android closed test starts |
| 6-8 | M03 |
| 9 | M04 |
| 10 | M05 |
| 11 | Phase 5 Review |
| 12 | Phase 6 Release, iOS submitted |
| 13-14 | Review buffer, fixes |
| ~19-21 | Android production access, submit |

Compare actual progress to this table at every gate and in `/app-factory status`. If more than one day behind, propose specific cuts from SPEC.md §5 (move to LATER.md).

## Gate G3

Show the milestone list with task counts and any task that needs the user (store consoles, device, payments). User approves. Record in STATUS.md.

# How it works

## One skill, many specialists

App Factory is a single skill (`skills/app-factory/SKILL.md`) that decides *what happens next and which skill does it*. It keeps only a small routing file in context and loads one phase reference at a time, so it stays cheap (about 150 tokens always-on).

## Phases and gates

| Phase | Command | Output | Gate (you decide) |
| --- | --- | --- | --- |
| 0 Bootstrap | `new` | App renamed, services wired, dev build on your phone | - |
| 1 Product | `idea` | `docs/SPEC.md`, `docs/DATA.md`, `LATER.md` | G1 Build it? |
| 2 Design | `design` | `docs/UX.md`, `src/theme/`, prototype branch, `docs/design-baseline.json` | G2 Design approved |
| 3 Plan | `plan` | `docs/plans/*.md` | G3 Plan approved |
| 4 Build | `build` | One PR per milestone | G4 per milestone |
| 5 Review | `review` | `docs/REVIEW.md` | G5 Ship-ready |
| 6 Release | `release` | `docs/RELEASE.md`, `store.config.json`, submission | G6 Submitted |
| 7 Learn | `retro`, `improve` | `LESSONS.md`, PRs to the factory and template | You merge |

`/app-factory status` reports the phase, day N of 14, the next action and anything blocked on you. `/app-factory fix` runs systematic debugging (with Sentry for reported crashes).

Gates are recorded with dates in `docs/STATUS.md`. If you ask for work in a later phase while a gate is open, Claude says which gate and asks once; you can always choose to proceed.

## The stack contract

Fixed for every app: Expo + Expo Router + TypeScript, Supabase, RevenueCat (`pro` entitlement), Sentry, EAS, StyleSheet + tokens, no analytics, iOS + Android. When a borrowed skill (or a request) points elsewhere (SwiftUI, StoreKit, Firebase, NativeWind, GitHub Actions), Claude keeps the reasoning and translates the implementation, or asks you first. Changing the contract is a deliberate PR to this repo, not something a single app does.

## Files the pipeline owns (in each app repo)

`docs/STATUS.md`, `SPEC.md`, `UX.md`, `DATA.md`, `plans/`, `REVIEW.md`, `RELEASE.md`, `design-baseline.json`, `store.config.json`, `LATER.md`, `LESSONS.md`, `app-factory.config.json`. Plugins that want to write elsewhere are redirected here. Templates for each are in `skills/app-factory/templates/`.

## Vendored guidance

`skills/app-factory/vendor/` holds pinned copies of Vercel's React Native rules and Draftbit's mobile design review. Their entry files are renamed so they never load as separate skills; the phase files say exactly when to read them, and SKILL.md lists the overrides (StyleSheet over NativeWind, native form sheets over JS bottom sheets, our file names). Refreshing them is a deliberate step; see `vendor/README.md`.

## Where your values live

Nothing personal is in this repo. Domain, bundle id prefix, Sentry org and repo names come from `app-factory.config.json` in each app repo (copied from your template).

## Repo layout

```
.claude-plugin/          plugin.json, marketplace.json
skills/app-factory/
  SKILL.md               routing, contract, gates, rules
  references/            setup.md, phase-0 … phase-7
  templates/             STATUS, SPEC, UX, DATA, RELEASE, REVIEW, LESSONS, CLAUDE.template.md, config
  vendor/                pinned third-party guidance
evals/                   claude plugin eval suite
scripts/check.sh         structural checks (also run in CI)
docs/                    SETUP, HOW-IT-WORKS, IMPROVING
LESSONS.md               cross-app lessons log
CHANGELOG.md
```

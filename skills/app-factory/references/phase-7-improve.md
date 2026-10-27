# Phase 7: Learn (retro → improve the factory)

The factory gets better only through apps that actually ship. Each app ends with a retro; the retro's output becomes a reviewed pull request against the factory. Nothing here edits the plugin or template directly.

## Retro (`/app-factory retro`)

Run after G6, and again 2-4 weeks after launch if real users surfaced new issues.

1. **Gather evidence** from the app repo, not memory:
   - `docs/STATUS.md`: planned vs actual day per gate; which gates ran over and why
   - `LESSONS.md`: lines captured during the build
   - `docs/REVIEW.md`: P0/P1 findings (each one is a question: why wasn't it caught earlier?)
   - `docs/design-baseline.json`: Design and AI Slop scores, Phase 2 vs Phase 5
   - Store outcomes: rejections and their reasons, Play production-access result
   - Sentry (MCP): top crashes in the first week; RevenueCat (MCP): did purchases work first time
   - `git log`: commits titled fix/revert/workaround; files changed most
2. **Classify** each lesson by target:
   - `skill`: a phase file, gate, rule, routing or vendored guidance was wrong, missing or ignored
   - `template`: plumbing in expo-app-factory (auth, purchases, workflows, config) needed fixing in every app
   - `doc`: the setup guide or workflow doc was wrong or unclear
   - `none`: specific to this app; keep it but don't propagate
3. **Score** each `skill`/`template`/`doc` lesson: cost (hours lost or risk), frequency (would it hit every app?), confidence (seen once vs repeatedly). Propose only lessons with high cost or high frequency; mark one-off, low-confidence ones "watch".
4. **Write** the cleaned table into `LESSONS.md` and a 5-line summary (what to keep, what to change, days planned vs actual) into STATUS.md.
5. **Ask** the user which lessons to take to `/app-factory improve`.

## Improve (`/app-factory improve`)

Turns approved lessons into pull requests. Repos come from `app-factory.config.json` (`github.factoryRepo`, `github.templateRepo`).

1. Clone (or use a local checkout of) the target repo on a branch `improve/<app-slug>-<yyyy-mm-dd>`. Never commit to `main`.
2. For each approved lesson, make the **smallest change that would have prevented it**:
   - Prefer tightening an existing rule, check or gate over adding a new section.
   - A rule that failed because it was vague gets a concrete example or a check, not more words.
   - If two lessons conflict, stop and ask.
   - Keep the stack contract unless the user explicitly asks to change it.
3. **Factory repo changes also need:**
   - An eval when the lesson is about behaviour: add or tighten a case in `evals/` that would have failed before the change (see `docs/IMPROVING.md` in the factory repo).
   - A `CHANGELOG.md` entry under "Unreleased", citing the app and the lesson.
   - A summarised line in the factory's root `LESSONS.md` (cross-app log): date, app, lesson, change, PR.
   - `scripts/check.sh` passing; `claude plugin validate .` passing.
4. Open the PR with `gh`: what happened in the app, the change, how it's verified (eval result or check output). One PR per repo per retro.
5. Report the PR links to the user and record them in the app's STATUS.md. The user reviews and merges; on merge they tag a release (see the factory's `docs/IMPROVING.md`).

## Guardrails

- Evidence first: every proposed change cites the STATUS/REVIEW/LESSONS/store/Sentry line it comes from.
- No speculative features: improvements come from something that happened, not from ideas.
- Vendored guidance (`vendor/`) is never hand-edited to fit a lesson; override it in SKILL.md or a phase file instead, so upstream refreshes stay clean.
- Removing a rule is a valid improvement when it caused friction and never caught anything.

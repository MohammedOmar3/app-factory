# Improving the factory

App Factory improves through apps that ship, not through ideas. Every change is evidence-based, reviewed by a person, and checked by evals before release. Nothing edits the plugin automatically.

## The loop

1. **Capture while building.** The skill adds a dated line to the app's `LESSONS.md` whenever a gate runs over, a store rejects, a fix repeats, a plugin misleads or a workaround is needed.
2. **Retro after submission** (`/app-factory retro`). Claude gathers evidence (STATUS gates vs plan, REVIEW findings, design scores, store outcomes, first-week Sentry and RevenueCat, git history), classifies each lesson as `skill`, `template`, `doc` or `none`, scores cost and frequency, and asks which to act on.
3. **Improve** (`/app-factory improve`). For each approved lesson, Claude makes the smallest change that would have prevented it, on a branch in this repo (and the template repo when the plumbing changed), and opens one PR per repo. Each PR:
   - cites the evidence (app, file, line)
   - adds or tightens an eval when the lesson is about behaviour
   - adds a CHANGELOG "Unreleased" entry and a line in `LESSONS.md`
   - passes `scripts/check.sh` and `claude plugin validate .`
4. **You review and merge.**
5. **Release** (below).

## Evals

The suite in `evals/` checks the behaviours that matter most: routing a new idea, respecting open gates, keeping the stack contract, keeping StyleSheet + tokens, reporting status honestly. Run it before every release:

```sh
claude plugin eval . --scaffold --runs 3 --ablation none     # quick: with-plugin only
claude plugin eval . --scaffold --runs 3                     # full: also compares against no plugin
```

`--scaffold` is needed because some cases set up a fake app repo (`evals/_fixtures/`). Results land in `evals/results/` (gitignored). A release needs every case at 1.00 over 3 runs; if one dips, read the transcript (`--keep-temp`) before changing anything, since the grader is sometimes the thing that's wrong.

**Adding a case:** one folder per behaviour, `prompt.md` (a realistic request, not naming the skill) plus graders. Prefer one grader on the result (`llm` with concrete PASS/FAIL, or `regex`) and one on the process (`tool_used`). Give cases the context a real app repo has (`case.yaml` + a scaffold from `evals/_fixtures/`). Every lesson that changes behaviour should leave a case behind that would have failed before the fix.

## Releasing

1. Move "Unreleased" in CHANGELOG.md under a new version (semver: patch for wording and rule tweaks, minor for new phases, commands or vendored sources, major for a stack-contract change).
2. Bump `version` in `.claude-plugin/plugin.json` to match.
3. Run the evals and `scripts/check.sh`.
4. Merge, then tag: `git tag v0.2.0 && git push --tags`.
5. On each machine: `/plugin marketplace update app-factory` (or `claude plugin marketplace update app-factory`).

## Refreshing vendored guidance

`skills/app-factory/vendor/README.md` records each source and commit. To refresh: re-copy from upstream, keep the renames, re-read the diff for anything that conflicts with the contract (styling, navigation, bottom sheets), update overrides in SKILL.md if needed, run the evals, and note the new commit in `vendor/README.md` and CHANGELOG.

## Planned: monthly freshness check

After the first app ships, a monthly scheduled task will check upstream (vendored sources, dependency plugins, new Expo SDK, Apple and Google requirements) and open a PR summarising what changed. Until then, check these by hand before starting a new app.

## What not to do

- Don't edit vendored files to fit a lesson; override them in SKILL.md or a phase file.
- Don't add speculative features; every change traces to something that happened.
- Don't loosen a gate or a check because it was annoying once; remove it only if it caused friction repeatedly and never caught anything.

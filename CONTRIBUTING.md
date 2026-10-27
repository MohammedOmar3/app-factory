# Contributing

Most changes come from `/app-factory improve` after an app ships (see [docs/IMPROVING.md](docs/IMPROVING.md)). Changes by hand follow the same rules.

## Before you open a PR

- [ ] The change traces to something that happened (an app, a rejection, a review finding), and the PR says what.
- [ ] It's the smallest change that would have prevented it. Tighten an existing rule before adding a new one.
- [ ] Behaviour changes have an eval case that fails without the change.
- [ ] `scripts/check.sh` passes; `claude plugin validate .` passes; evals pass at 1.00 over 3 runs.
- [ ] CHANGELOG "Unreleased" entry; a line in `LESSONS.md` if it came from an app.
- [ ] No personal values (domains, bundle ids, orgs): those belong in `app-factory.config.json`.
- [ ] Vendored files untouched (override in SKILL.md instead).

## Style for skill files

- Write for Claude reading it cold: concrete steps, the exact file or command, what to hand back to the user.
- Keep SKILL.md small; detail goes in the phase reference that needs it.
- Tables for routing and lookups, numbered lists for steps, no filler.

## Changing the stack contract

Possible, but deliberate: a PR that explains why, updates SKILL.md, every affected phase file, `templates/CLAUDE.template.md`, the evals, and is released as a major version.

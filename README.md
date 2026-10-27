# App Factory

**Idea to App Store and Google Play in 14 days, without a Mac.** A Claude Code plugin that runs a gated pipeline over a fixed, production-ready stack (Expo, Supabase, RevenueCat, Sentry, EAS) and gets better with every app you ship.

```
/app-factory idea      → validated, scoped spec
/app-factory design    → tokens, UX spec, clickable prototype on your phone, scored design review
/app-factory plan      → milestone plans with a verification per task
/app-factory build     → one milestone per branch, previewed on your phone, PR
/app-factory review    → product, device, code/security, stability, store readiness
/app-factory release   → store copy, screenshots, privacy answers, submission
/app-factory retro     → what went wrong or slow
/app-factory improve   → turns lessons into a PR against this repo
```

## Why

Shipping a small app is mostly not code. It's choosing a stack that won't fight you, wiring auth, payments and crash reporting, passing App Store review, and not losing two weeks to scope creep. App Factory fixes the stack, does the wiring once in a template, and puts a gate (your decision) between each phase so Claude can't run ahead of you.

It doesn't replace the specialist skills; it **orchestrates** them and keeps them inside one workflow:

| Source | Used for |
| --- | --- |
| [superpowers](https://github.com/obra/superpowers) | Brainstorming, plans, execution, TDD, debugging, code review, verification |
| [Expo skills](https://github.com/expo/skills) + Expo MCP | All Expo and EAS implementation |
| [Apple skills](https://github.com/rshankras/claude-code-apple-skills) | Product validation, UX writing, monetization, App Store copy, release review (no Swift generators) |
| Supabase, RevenueCat, Sentry plugins | Live backend, purchases and crash work through their MCP servers |
| [Vercel React Native rules](https://github.com/vercel-labs/agent-skills) (vendored) | Frontend engineering standard |
| [Draftbit mobile-taste](https://github.com/draftbit/mobile-taste-skill) (vendored) | Anti-slop design review and scoring |

## What you need

- A Windows, Linux or Mac computer for Claude Code (or Claude Code on the web), and an iPhone or Android phone
- Apple Developer Program ($99/year), Google Play Console ($25 once)
- Expo Starter plan ($19/month; the Expo MCP server needs a paid plan)
- Free tiers of Supabase, RevenueCat, Sentry; a domain for privacy/support pages

## Install

```sh
claude plugin marketplace add OWNER/app-factory
claude plugin install app-factory@app-factory
```

Then follow **[docs/SETUP.md](docs/SETUP.md)**: dependency plugins, accounts, your config file, and the template repo.

## Docs

- [SETUP.md](docs/SETUP.md): from zero to your first `/app-factory new`
- [HOW-IT-WORKS.md](docs/HOW-IT-WORKS.md): phases, gates, files, the stack contract, vendored guidance
- [IMPROVING.md](docs/IMPROVING.md): the retro → improve → eval → release loop
- [CONTRIBUTING.md](CONTRIBUTING.md): changing the factory by hand
- [LESSONS.md](LESSONS.md): what every shipped app taught the factory
- [CHANGELOG.md](CHANGELOG.md)

## Status

Early. The pipeline is complete and its core behaviours are covered by evals (`claude plugin eval .`), but it hasn't shipped an app yet; the first apps will reshape it. That's the point of the retro loop.

## License

MIT. Vendored third-party material keeps its own MIT license; see [NOTICE.md](NOTICE.md).

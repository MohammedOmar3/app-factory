# Setup

From zero to `/app-factory new`. Budget a day for accounts (Apple approval can take longer) and about a week the first time you build the template.

## 1. Accounts (once)

| Account | What to do | Why |
| --- | --- | --- |
| Apple Developer Program | Enroll ($99/year). In App Store Connect: accept agreements, complete **Paid Apps** agreement, tax and banking. Create an **App Store Connect API key** (Admin) and an **In-App Purchase key** | EAS submits with the API key; RevenueCat needs the IAP key; without Paid Apps, purchases never load |
| Google Play Console | Create the account ($25). **Decide personal vs organization first**: a personal account made after Nov 13, 2023 needs a 12-tester, 14-day closed test for every new app; an organization account (D-U-N-S number) doesn't. Create a Google Cloud service account with Play access | EAS and RevenueCat use the service account |
| Expo | Starter plan or higher | Expo MCP server requires a paid plan; priority builds |
| Supabase | Free organization | One project per app |
| RevenueCat | Free account | One project per app |
| Sentry | Organization in the region you want (EU or US); create an org auth token | Region can't change later |
| GitHub | Account; `gh auth login` | Repos, PRs, the improve loop |
| Domain + static host | Any static host (GitHub Pages, Vercel, Netlify, Azure Static Web Apps) | Privacy, support and terms pages per app |

## 2. Claude Code and the dependency plugins

Install Claude Code on your computer, then:

```sh
claude plugin marketplace add anthropics/claude-plugins-official
claude plugin install superpowers@claude-plugins-official
claude plugin install expo@claude-plugins-official
claude plugin install supabase@claude-plugins-official

claude plugins marketplace add RevenueCat/ai-toolkit
claude plugins install revenuecat
claude plugins install revenuecat-play-billing

claude plugin marketplace add getsentry/sentry-mcp
claude plugin install sentry-mcp@sentry-mcp

claude plugin marketplace add rshankras/claude-code-apple-skills
claude plugin install apple-skills@indie-apple-stack
```

Don't install `apple@indie-apple-stack` (SwiftShip): it runs a competing Swift/Xcode workflow.

Optional, for performance reviews only: `npx skills add callstackincubator/agent-skills --skill react-native-best-practices` from your app repo.

Also: `npm i -g eas-cli`, `eas login`.

## 3. Install App Factory

```sh
claude plugin marketplace add MohammedOmar3/app-factory
claude plugin install app-factory@app-factory
```

Start `claude`, run `/reload-plugins`, then `/mcp` and authenticate Expo, Supabase, RevenueCat and Sentry.

**Check it:** ask Claude "run the app-factory setup verification". It follows `skills/app-factory/references/setup.md` and reports anything missing.

## 4. The template repo (once)

Every app starts from a GitHub **template repository**, `expo-app-factory`, that already has auth, purchases, Sentry, EAS workflows and the house rules wired. You build it once:

1. `npx create-expo-app@latest expo-app-factory`, then follow the "reusable template repo" section of the workflow guide (folder layout, `app.config.ts`, `eas.json`, Supabase client, RevenueCat, Sentry, three EAS workflows).
2. Copy these from this plugin into the template root:
   - `skills/app-factory/templates/CLAUDE.template.md` → `CLAUDE.md` (merge with the one Expo generated)
   - `skills/app-factory/templates/app-factory.config.json` → `app-factory.config.json`, filled with your values
3. Add a `.claude/settings.json` that enables the plugins (see `references/setup.md` for the snippet).
4. Take it all the way to TestFlight as a throwaway app, so every integration is proven before your first real idea.
5. On GitHub: Settings → mark as **Template repository**. Put its name in `github.templateRepo` in the config.

## 5. Your config

`app-factory.config.json` holds everything personal, so the plugin itself stays generic:

| Key | Example | Used for |
| --- | --- | --- |
| `webBaseUrl` | `https://yourdomain.dev` | Privacy, support, terms URLs per app |
| `bundleIdPrefix` | `dev.yourdomain` | Bundle id `dev.yourdomain.<slug>` |
| `supportEmail` | `support@yourdomain.dev` | Support page, store listings |
| `sentry.org`, `sentry.region` | `your-org`, `eu` | Sentry project creation |
| `github.factoryRepo` | `you/app-factory` | `/app-factory improve` PRs |
| `github.templateRepo` | `you/expo-app-factory` | New apps, template improvements |
| `github.websiteRepoPath` | local path | Where legal pages get written |
| `googlePlayAccount` | `personal` or `organization` | Android timeline |

## 6. Your phone

`eas device:create`, open the link on your iPhone, enable Developer Mode when asked. Development builds install from EAS links; preview updates load inside the development build.

## 7. First app

1. GitHub → expo-app-factory → **Use this template** → new repo → clone.
2. `cd` into it, `claude`, then `/app-factory new` (or `/app-factory idea` if you're still choosing what to build).

## Troubleshooting

- **The skill doesn't trigger:** run `/app-factory` explicitly (the full name is `/app-factory:app-factory`); check `claude plugin list`.
- **MCP tools missing:** `/mcp`, re-authenticate; the Expo MCP needs a paid EAS plan.
- **Plugin marketplace name mismatch in `.claude/settings.json`:** `claude plugin marketplace list` shows the real names.
- **Cloud sessions:** interactive OAuth, emulators and store consoles don't work there; the skill notes those steps in `docs/STATUS.md` for your PC.

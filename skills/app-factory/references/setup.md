# Setup: plugins this skill depends on

Install once per machine (PC). For cloud sessions, the project's `.claude/settings.json` enables them (snippet below).

## Install

```sh
# Anthropic's official marketplace (usually present already)
claude plugin marketplace add anthropics/claude-plugins-official

claude plugin install superpowers@claude-plugins-official
claude plugin install expo@claude-plugins-official        # also registers the Expo MCP server
claude plugin install supabase@claude-plugins-official    # MCP + supabase skills

claude plugins marketplace add RevenueCat/ai-toolkit
claude plugins install revenuecat
claude plugins install revenuecat-play-billing

claude plugin marketplace add getsentry/sentry-mcp
claude plugin install sentry-mcp@sentry-mcp

claude plugin marketplace add rshankras/claude-code-apple-skills
claude plugin install apple-skills@indie-apple-stack
```

Optional, for the Phase 5 performance pass (skill only, from the project root):

```sh
npx skills add callstackincubator/agent-skills --skill react-native-best-practices
```

Install just that skill, not Callstack's `building-react-native-apps` plugin: the plugin also brings react-navigation and upgrade skills that compete with Expo Router and expo-upgrade.

For the Brand & ASO step and store assets (`references/brand.md`, `references/phase-6-release.md`), nothing is required beyond Claude Code itself:

- **Review board:** a Claude Design artifact (the `Artifact` tool). Private by default; the user shares it from the page's Share menu.
- **SVG to PNG:** `npx -y @resvg/resvg-js-cli in.svg out.png` (tested). Claude Code asks for approval of the first `npx` run.
- **HTML to PNG** (screenshot frames, 1024×500 Play feature graphic): headless Edge, preinstalled on Windows 11 (tested at 1024×500): `"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --headless=new --disable-gpu --hide-scrollbars --window-size=W,H --screenshot=out.png file:///path/to/frame.html`. Headless Chrome takes the same flags.

Optional upgrades (not required, not verified as part of this skill):

- **Figma:** `claude plugin install figma@claude-plugins-official` (official remote MCP; writes to the canvas). It needs a Professional plan Full or Dev seat; the free Starter plan allows 20 calls a month. Check Figma's pricing page before buying.
- **Image generation for raster art.** Two routes seen to fail without paid access, so do not rely on them:
  - Gemini API (for example `nanobanana-mcp-server`): a key from a project without billing returns `429 RESOURCE_EXHAUSTED ... limit: 0`. Link billing first.
  - OpenRouter (`openrouter-banana-mcp`): needs credits (`402` without them), exposes only a `prompt` parameter (no reference image), and crashes on `mcp` 2.x unless pinned with `--with 'mcp<2'`.
  - If you register an MCP whose key is in a user environment variable: Claude Code expands `${VAR}` from its own process environment, so a variable set with `setx` after launch is not seen. Either start Claude Code from a new terminal, or launch the server through a wrapper that reads the user-scope variable, for example `claude mcp add <name> --scope user -- powershell -NoProfile -Command '$env:KEY=[Environment]::GetEnvironmentVariable("KEY","User"); uvx ...'`. Never paste a key into a session.

Nothing to install for Vercel's React Native rules or Draftbit's design review: they ship inside this skill under `vendor/`. Supabase's postgres best-practices skill comes with the supabase plugin.

Do **not** install `apple@indie-apple-stack` (SwiftShip). Its `/apple:*` commands run a Swift/Xcode workflow that competes with this one.

Then in a session: `/reload-plugins`, `/mcp`, and authenticate Expo, Supabase, RevenueCat, Sentry.

## Verify

Ask Claude to confirm each of these is available and report any missing:

- Skills: `superpowers:brainstorming`, `superpowers:writing-plans`, `superpowers:executing-plans`, `superpowers:verification-before-completion`, `expo-overview`, `eas-workflows`, `apple-skills:product`, `apple-skills:app-store`, `supabase-postgres-best-practices`
- Files: `vendor/react-native-skills/INDEX.md`, `vendor/mobile-taste/skills/mobile-design-review/REVIEW.md`
- MCP servers: expo, supabase, revenuecat, sentry (each answers a trivial read, e.g. "who am I"); the `Artifact` tool publishes a private page; `npx -y @resvg/resvg-js-cli` exports a test SVG to PNG; headless Edge exports a test HTML file to PNG. Only if installed: figma (creates a frame in a test file); an image-generation server (returns one image)
- CLIs: `eas whoami`, `gh auth status`

## Project settings (commit to the template)

`.claude/settings.json`, merged with what create-expo-app generated:

```json
{
  "enabledPlugins": {
    "expo@claude-plugins-official": true,
    "superpowers@claude-plugins-official": true,
    "supabase@claude-plugins-official": true,
    "figma@claude-plugins-official": true
  },
  "extraKnownMarketplaces": {
    "indie-apple-stack": { "source": { "source": "github", "repo": "rshankras/claude-code-apple-skills" } },
    "revenuecat": { "source": { "source": "github", "repo": "RevenueCat/ai-toolkit" } },
    "sentry-mcp": { "source": { "source": "github", "repo": "getsentry/sentry-mcp" } }
  }
}
```

Marketplace names in `enabledPlugins` must match what `claude plugin marketplace list` shows on your machine; add the RevenueCat, Sentry and apple-skills plugins there once you've confirmed their marketplace names. Check the current settings schema in the Claude Code docs if a key is rejected.

## Where this skill lives

`expo-app-factory/.claude/skills/app-factory/` in the template repo, so every app made from the template carries it.

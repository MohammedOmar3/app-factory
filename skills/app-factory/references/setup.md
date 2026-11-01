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

For the Brand & ASO step and store assets (`references/brand.md`):

```sh
claude plugin install figma@claude-plugins-official      # official Figma MCP (remote server; writes to the canvas)
```

Figma needs a Professional plan Full or Dev seat (the MCP server is not available on the free Starter plan beyond 20 calls a month); check Figma's pricing page before buying.

Image generation uses the community `nanobanana-mcp-server` (github.com/zhongweili/nanobanana-mcp-server, MIT) for Google's Gemini image models. Create a Gemini API key in Google AI Studio on a billing-enabled project with a budget alert, then set it yourself in your own terminal (never paste it into a session): PowerShell `setx GEMINI_API_KEY "<your key>"`, restart the terminal. Then:

```sh
claude mcp add nanobanana --scope user --env 'GEMINI_API_KEY=${GEMINI_API_KEY}' -- uvx nanobanana-mcp-server@latest
```

The single quotes keep `${GEMINI_API_KEY}` literal so the key is read from your environment at launch, not stored. It needs `uv` installed (`uvx`). Images are saved to `~/nanobanana-images` (override with `IMAGE_OUTPUT_DIR`). Check how it takes reference images (`edit_image`, `upload_file`) against the repo README before relying on style references; the runner-up is `@mindstone/mcp-server-nano-banana` (`npx -y`).

Nothing to install for Vercel's React Native rules or Draftbit's design review: they ship inside this skill under `vendor/`. Supabase's postgres best-practices skill comes with the supabase plugin.

Do **not** install `apple@indie-apple-stack` (SwiftShip). Its `/apple:*` commands run a Swift/Xcode workflow that competes with this one.

Then in a session: `/reload-plugins`, `/mcp`, and authenticate Expo, Supabase, RevenueCat, Sentry.

## Verify

Ask Claude to confirm each of these is available and report any missing:

- Skills: `superpowers:brainstorming`, `superpowers:writing-plans`, `superpowers:executing-plans`, `superpowers:verification-before-completion`, `expo-overview`, `eas-workflows`, `apple-skills:product`, `apple-skills:app-store`, `supabase-postgres-best-practices`
- Files: `vendor/react-native-skills/INDEX.md`, `vendor/mobile-taste/skills/mobile-design-review/REVIEW.md`
- MCP servers: expo, supabase, revenuecat, sentry (each answers a trivial read, e.g. "who am I"); figma (creates a frame in a test file); the image-generation server once installed (returns one image)
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

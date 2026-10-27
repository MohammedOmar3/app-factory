# Vendored third-party guidance

Copied at fixed versions so they never auto-trigger as standalone skills (their SKILL.md files are renamed) and don't change under you. app-factory loads them only where its phase files say so. Refresh deliberately: re-copy, re-read, re-check the overrides in app-factory SKILL.md.

| Folder | Source | Commit | License |
| --- | --- | --- | --- |
| mobile-taste/ | github.com/draftbit/mobile-taste-skill (review skill, shared references and blocks; build skill kept only as REFERENCE.md for citations) | eb58d98 (2026-07-02) | MIT, see mobile-taste/LICENSE |
| react-native-skills/ | github.com/vercel-labs/agent-skills, skills/react-native-skills | 6ec2693 | MIT (declared in the skill's frontmatter) |

Renames: mobile-design-review/SKILL.md → REVIEW.md, mobile-taste/SKILL.md → REFERENCE.md, react-native-skills/SKILL.md → INDEX.md. Paths inside the vendored files were updated to the new names; no other edits.

Bare citations like "SKILL.md 6.4" inside mobile-taste files mean sections of `mobile-taste/skills/mobile-taste/REFERENCE.md`.

#!/usr/bin/env bash
# Structural checks for the app-factory plugin. Runs in CI and before every PR.
set -uo pipefail
cd "$(dirname "$0")/.."
fail=0
err(){ echo "✗ $*"; fail=1; }
ok(){ echo "✓ $*"; }
S=skills/app-factory

# 1. Manifests and JSON templates parse
for f in .claude-plugin/plugin.json .claude-plugin/marketplace.json $S/templates/app-factory.config.json; do
  python3 -c "import json,sys; json.load(open(sys.argv[1]))" "$f" 2>/dev/null && ok "valid JSON: $f" || err "invalid JSON: $f"
done

# 2. plugin.json version matches the latest released CHANGELOG version
pv=$(python3 -c "import json; print(json.load(open('.claude-plugin/plugin.json'))['version'])")
cv=$(grep -m1 -oE '^## [0-9]+\.[0-9]+\.[0-9]+' CHANGELOG.md | cut -c4-)
[ "$pv" = "$cv" ] && ok "version $pv matches CHANGELOG" || err "plugin.json version $pv != latest CHANGELOG version $cv"

# 3. SKILL.md frontmatter
head -1 $S/SKILL.md | grep -q '^---$' || err "SKILL.md has no frontmatter"
grep -q '^name: app-factory$' $S/SKILL.md || err "SKILL.md name must be app-factory"
desc=$(awk '/^description:/{sub(/^description: /,""); print; exit}' $S/SKILL.md)
[ -n "$desc" ] && [ ${#desc} -le 1024 ] && ok "description ${#desc} chars" || err "description missing or over 1024 chars (${#desc})"

# 4. Every referenced path inside the skill exists
missing=0
while read -r p; do
  [ -e "$S/$p" ] || { err "missing referenced path: $p"; missing=1; }
done < <(grep -ohE '(references|templates|vendor)/[A-Za-z0-9_./-]+' $S/SKILL.md $S/references/*.md | sed -E 's/[.,)]+$//' | sort -u)
[ $missing -eq 0 ] && ok "all referenced paths exist"

# 5. Only one SKILL.md in the plugin (vendored entry files must stay renamed)
n=$(find skills -name SKILL.md | wc -l)
[ "$n" -eq 1 ] && ok "one SKILL.md" || err "found $n SKILL.md files; vendored skills must not be named SKILL.md"

# 6. No personal values leaked into the generic plugin.
#    Put your own strings (domain, bundle prefix, email), one regex per line, in
#    scripts/.personal-denylist (gitignored). Emails are always checked.
pat='[A-Za-z0-9._%+-]+@(hotmail|gmail|outlook|icloud|yahoo)\.com'
[ -f scripts/.personal-denylist ] && pat="$pat|$(grep -v '^#' scripts/.personal-denylist | grep -v '^$' | paste -sd'|')"
hits=$(grep -rniE "$pat" --exclude-dir=.git --exclude-dir=results --exclude=.personal-denylist --exclude=check.sh . || true)
if [ -n "$hits" ]; then err "personal values found:"; echo "$hits" | head; else ok "no personal values"; fi

# 7. Each eval case has a prompt and at least one grader
for d in evals/*/; do
  case "$d" in evals/_fixtures/|evals/results/|evals/mocks/) continue;; esac
  { [ -f "$d/prompt.md" ] || [ -f "$d/case.yaml" ]; } || err "eval $d has no prompt.md or case.yaml"
  ls "$d"/graders/*.md >/dev/null 2>&1 || grep -q '^graders:' "$d/case.yaml" 2>/dev/null || err "eval $d has no graders"
done
ok "eval cases checked"

[ $fail -eq 0 ] && echo "All checks passed." || { echo "Checks failed."; exit 1; }

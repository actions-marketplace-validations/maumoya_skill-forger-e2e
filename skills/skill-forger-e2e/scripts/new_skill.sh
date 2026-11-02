#!/usr/bin/env bash
# Scaffold a new skill repo from templates/repo. Writes only inside TARGET_DIR. No network.
# Usage: new_skill.sh SKILL_NAME TARGET_DIR "Owner Name" [GITHUB_USER] ["One-sentence description."]
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
name="${1:?usage: new_skill.sh SKILL_NAME TARGET_DIR \"Owner Name\" [GITHUB_USER] [DESCRIPTION]}"
target="${2:?missing TARGET_DIR}"
owner="${3:?missing \"Owner Name\"}"
gh_user="${4:-OWNER}"
desc="${5:-REPLACE: what this skill does and for whom, in one sentence.}"

if ! [[ "$name" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]] || [ ${#name} -gt 64 ]; then
  echo "name must be lowercase letters, digits and single hyphens, at most 64 chars: $name" >&2; exit 1
fi
if [[ "$name" == *claude* || "$name" == *anthropic* ]]; then
  echo "name must not contain 'claude' or 'anthropic': $name" >&2; exit 1
fi
if [ -e "$target" ] && [ -n "$(ls -A "$target" 2>/dev/null)" ]; then
  echo "target exists and is not empty: $target" >&2; exit 1
fi

title="$(awk -F- -v OFS=' ' '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2); print}' <<<"$name")"

mkdir -p "$target"
cp -R "$here/../templates/repo/." "$target/"
mv "$target/skills/__NAME__" "$target/skills/$name"

export S_NAME="$name" S_TITLE="$title" S_OWNER="$owner" S_GH="$gh_user" S_DESC="$desc" S_YEAR="$(date +%Y)"
find "$target" -type f ! -path '*/.git/*' -print0 | while IFS= read -r -d '' f; do
  perl -pi -e 's/__NAME__/$ENV{S_NAME}/g; s/__TITLE__/$ENV{S_TITLE}/g; s/__OWNER__/$ENV{S_OWNER}/g; s/__GH__/$ENV{S_GH}/g; s/__DESCRIPTION__/$ENV{S_DESC}/g; s/__YEAR__/$ENV{S_YEAR}/g' "$f"
done
# copied after the substitution so the linter keeps its own placeholder patterns
mkdir -p "$target/scripts"
cp "$here/lint_skill.sh" "$target/scripts/lint_skill.sh"
chmod +x "$target/scripts/lint_skill.sh"

[ -d "$target/.git" ] || git -C "$target" init -q -b main
echo "created $target (skill: $name)"
echo "next: fill the REPLACE markers, then run: bash $target/scripts/lint_skill.sh $target"

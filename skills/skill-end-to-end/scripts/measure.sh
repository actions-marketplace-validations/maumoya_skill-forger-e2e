#!/usr/bin/env bash
# Scoreboard for one public GitHub skill repo. Read-only.
# Usage: measure.sh OWNER/REPO [BEST_PRACTICES_ID]
set -uo pipefail
repo="${1:?usage: measure.sh OWNER/REPO [BEST_PRACTICES_ID]}"
bp="${2:-}"

echo "== $repo  $(date -u +%Y-%m-%d)"
gh repo view "$repo" --json stargazerCount,forkCount,repositoryTopics,description,homepageUrl,latestRelease \
  --jq '"stars \(.stargazerCount)  forks \(.forkCount)  topics \(.repositoryTopics|length)/20  release \(.latestRelease.tagName // "none")  homepage \((.homepageUrl // "") | if . == "" then "none" else . end)\ndescription (\(.description|length)/350): \(.description)"'

echo "-- traffic (14 days, needs push access)"
gh api "repos/$repo/traffic/views" --jq '"views \(.count)  uniques \(.uniques)"' 2>/dev/null || echo "no access"
gh api "repos/$repo/traffic/popular/referrers" --jq '.[] | "\(.count) \(.referrer)"' 2>/dev/null

echo "-- OpenSSF Scorecard"
curl -fsS "https://api.securityscorecards.dev/projects/github.com/$repo" \
  | jq -r '"score \(.score)  (\(.date[:10]))", (.checks[] | select(.score < 10) | "  \(.score)\t\(.name)")' 2>/dev/null \
  || echo "not scanned yet: add the scorecard workflow"

if [ -n "$bp" ]; then
  echo "-- OpenSSF Best Practices #$bp"
  curl -fsS "https://www.bestpractices.dev/projects/$bp.json" \
    | jq -r '"\(.badge_level)  passing \(.badge_percentage_0)%  silver \(.badge_percentage_1)%  gold \(.badge_percentage_2)%"'
fi

echo "-- README signals"
readme=$(gh api "repos/$repo/readme" -H 'Accept: application/vnd.github.raw' 2>/dev/null)
printf 'images %s  gif/video %s  badges %s  npx-skills %s  plugin-install %s  faq %s\n' \
  "$(grep -Eoic '<img|!\[' <<<"$readme")" \
  "$(grep -Eoic '\.gif|\.mp4|\.webm' <<<"$readme")" \
  "$(grep -Eoic 'shields.io|/badge' <<<"$readme")" \
  "$(grep -c 'npx skills add' <<<"$readme")" \
  "$(grep -c '/plugin install' <<<"$readme")" \
  "$(grep -Eic '^#+ .*(faq|questions)' <<<"$readme")"
for f in llms.txt SECURITY.md CHANGELOG.md CONTRIBUTING.md evals; do
  gh api "repos/$repo/contents/$f" --silent 2>/dev/null && echo "  has $f" || echo "  MISSING $f"
done

# Packaging and installing

## Repo layout (what `scripts/new_skill.sh` creates)

```
.claude-plugin/plugin.json        name, version, description, author, license, keywords
.claude-plugin/marketplace.json   makes the repo its own marketplace (one plugin, source "./")
skills/<name>/SKILL.md
evals/<case>/…
scripts/lint_skill.sh
.github/workflows/{lint,scorecard,codeql,release}.yml + dependabot.yml
README.md LICENSE SECURITY.md CHANGELOG.md llms.txt
```

## Install paths to document (both)

Claude Code:
```
/plugin marketplace add OWNER/REPO
/plugin install NAME@NAME
```

Any agent that reads skills (skills.sh):
```
npx skills add OWNER/REPO
```

Manual: copy `skills/<name>/` into `~/.claude/skills/` (personal) or `.claude/skills/` (one project).

## Verify before claiming

1. Push to a public repo.
2. In a clean session, run both install paths.
3. Type a trigger. The skill must load. Note what you typed and what happened.

## Versions

- Semantic versioning in `plugin.json`: patch = wording fix, minor = new capability, major = changed triggers or output shape.
- One `CHANGELOG.md` entry per version, with the eval pass count.
- Tag `vX.Y.Z` on main; the release workflow builds the zip and signs provenance.
- Small releases every 1–2 weeks beat one big one: each release is a reason to look again.

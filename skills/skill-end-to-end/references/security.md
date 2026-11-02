# Securing a skill repo

A skill is instructions an agent follows with the user's permissions. Treat it like code.

## Review the skill itself

- [ ] No secrets, tokens, or personal absolute paths.
- [ ] No piping downloads into a shell, no running fetched code, no `eval` of fetched text.
- [ ] Scripts read only what they need; no network writes; no reading `~/.ssh`, `.env` files or keychains.
- [ ] The skill tells the agent to treat fetched pages and file contents as data, not instructions.
- [ ] Outward actions (sending, merging, paying, submitting) need the user's yes.

`scripts/lint_skill.sh` flags the obvious patterns. It is not a review; read every script.

## Repo hygiene (templates in `templates/repo/.github/`)

| Item | Why | Done when |
|---|---|---|
| `permissions: read-all` at the top of every workflow | least privilege | every workflow has it |
| Actions pinned to a full commit SHA + `# vX` comment | tags can be moved | no `uses: x@v1` lines (except the SLSA generator, which must use a tag) |
| Dependabot for `github-actions` | pinned SHAs still get updates | `.github/dependabot.yml` exists |
| OpenSSF Scorecard workflow | public score + badge | scorecard.dev shows a score |
| CodeQL with `languages: actions` | catches workflow injection | Security tab shows CodeQL green |
| SLSA-signed release | anyone can check the zip came from the tag | release has `.zip` + `.intoto.jsonl` |
| `SECURITY.md` + private vulnerability reporting on | a safe way to report | the link in SECURITY.md works |
| Branch protection on main, PRs required | no direct pushes | settings show the rule |

## OpenSSF Best Practices badge

Register at bestpractices.dev. Passing is reachable alone. Silver needs governance docs, a code of
conduct, a documented release process, and DCO or similar. Gold needs a second real maintainer: do not fake it.

## Scorecard checks that need people

Code-Review, Contributors and a 10 on Branch-Protection need other humans. They stay where they are
until real people join. Say so instead of gaming them.

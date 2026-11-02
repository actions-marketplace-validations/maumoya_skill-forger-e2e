# Skill Forger E2E

Make an agent skill end to end: decide, define, author, test with evals, package as a Claude Code
plugin, secure, launch and measure. Eight gated phases, a scaffold script and a keyless linter.

For anyone who wants to ship a `SKILL.md` that people find, trust and install, not just one that runs on their own machine.

```
0 Decide → 1 Define → 2 Author → 3 Test → 4 Package → 5 Secure → 6 Launch → 7 Loop
```

Each phase ends in a gate the agent must pass (and show) before moving on.

## Install

Claude Code plugin:

```
/plugin marketplace add maumoya/skill-forger-e2e
/plugin install skill-forger-e2e@skill-forger-e2e
```

Any agent that reads skills:

```
npx skills add maumoya/skill-forger-e2e
```

## Use

Type one of:

- `make a skill that turns meeting transcripts into action items`
- `package my skill as a plugin`
- `write evals for my skill`
- `publish my skill` (picks up at the phase you are in)

## What is inside

| Phase | Gate | Tooling |
|---|---|---|
| 0 Decide | one sentence: who, what, better than what exists | search commands |
| 1 Define | triggers, non-triggers, done-when, saved baseline | — |
| 2 Author | linter prints `PASS` | `new_skill.sh`, `lint_skill.sh`, [authoring.md](skills/skill-forger-e2e/references/authoring.md) |
| 3 Test | every eval passes and the skill beats the baseline | eval template, [testing.md](skills/skill-forger-e2e/references/testing.md) |
| 4 Package | clean install from the public repo fires the skill | plugin + marketplace JSON, [packaging.md](skills/skill-forger-e2e/references/packaging.md) |
| 5 Secure | Scorecard ran, CodeQL green, signed release | SHA-pinned workflows, SLSA release, [security.md](skills/skill-forger-e2e/references/security.md) |
| 6 Launch | 10-second README test + one channel submitted | [launch.md](skills/skill-forger-e2e/references/launch.md) |
| 7 Loop | one measured fix per round | `measure.sh` |

### Scaffold a new skill repo

```bash
bash skills/skill-forger-e2e/scripts/new_skill.sh my-skill ../my-skill "Your Name" your-github "What it does, for whom."
```

You get `SKILL.md`, plugin and marketplace JSON, an eval case, lint/Scorecard/CodeQL/release
workflows with actions pinned to commit SHAs, Dependabot, `SECURITY.md`, `CHANGELOG.md`, `llms.txt`,
an MIT license, and a README in the order that works.

### Lint any skill repo

```bash
bash skills/skill-forger-e2e/scripts/lint_skill.sh path/to/repo
```

Checks frontmatter rules, name/folder match, description length and trigger wording, broken links to
`references/` and `scripts/`, plugin JSON, eval layout, unpinned actions, pipe-to-shell, secret-like
strings and personal paths. No API key, no network.

## How it is tested

- CI lints this repo, then scaffolds a fresh skill and lints that, on every PR.
- `evals/` holds one case per promise. Run `claude plugin eval . --allow-tools` (bills your account).

## FAQ

### How is this different from Anthropic's skill-creator?

skill-creator helps you write and evaluate a skill. This covers that and what comes after: packaging
as a plugin, securing the repo, launching, and measuring.

### Does it send my data anywhere?

No. The scaffold and linter are local and write only inside the folder you give them. `measure.sh`
only reads public GitHub and OpenSSF data for the repo you name.

### Will it get my skill stars?

No one can promise that. It makes the skill easy to find, trust and install, and measures what changes.

### Does it post or submit anything for me?

No. Every post, form and PR to another repo is prepared for you to send yourself.

## License

MIT © 2026 Mauricio Alonso Moya Tapia

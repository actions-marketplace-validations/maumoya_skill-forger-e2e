# Contributing

1. Open an issue first for anything bigger than a typo, so we agree on the change.
2. Branch, change, and run the linter and the scaffold check locally:
   ```bash
   bash skills/skill-forger-e2e/scripts/lint_skill.sh .
   bash skills/skill-forger-e2e/scripts/new_skill.sh demo-skill /tmp/demo "You" you "Demo." && bash /tmp/demo/scripts/lint_skill.sh /tmp/demo
   ```
3. If you change what the skill promises, add or update a case in `evals/`.
4. Open a PR. CI must be green. A maintainer reviews and merges.

Keep SKILL.md under 500 lines; put detail in `references/`. English, plain words, no emojis.

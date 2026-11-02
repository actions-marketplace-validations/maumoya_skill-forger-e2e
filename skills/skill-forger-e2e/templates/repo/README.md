# __TITLE__

__DESCRIPTION__

<!-- Put a picture or a ≤10 s GIF here: one input → one result. -->

## Install

Claude Code plugin:

```
/plugin marketplace add __GH__/__NAME__
/plugin install __NAME__@__NAME__
```

Any agent that reads skills:

```
npx skills add __GH__/__NAME__
```

## Use

Type: `TRIGGER ONE`

## How it is tested

`evals/` holds one case per promise. Run `claude plugin eval . --allow-tools`.
Every PR runs `scripts/lint_skill.sh` in CI.

## FAQ

### What does it do?

__DESCRIPTION__

### Does it send my data anywhere?

No. It is instructions and local scripts only.

## License

MIT © __YEAR__ __OWNER__

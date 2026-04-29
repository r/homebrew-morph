# homebrew-morph

Homebrew tap for [Morph](https://github.com/r/morph) — behavioral version
control for AI-assisted development.

## Install

```bash
brew tap r/morph
brew install morph
```

This installs both binaries:

- `morph` — the CLI.
- `morph-mcp` — the MCP server used by Cursor, Claude Code, and OpenCode.

Verify with:

```bash
morph --version
morph version --json
```

## Updating

The `Formula/morph.rb` file in this repo is updated automatically by the
[release-homebrew](https://github.com/r/morph/blob/main/.github/workflows/release-homebrew.yml)
workflow in `r/morph` whenever a `v*` tag is pushed. Do not hand-edit
the formula here — your changes will be clobbered on the next release.

See [docs/RELEASING.md](https://github.com/r/morph/blob/main/docs/RELEASING.md)
for the full release runbook.

# Contributing to AIONE

Thank you for contributing. This document defines the workflow and standards for
all contributors.

## Before You Start

1. Read [README.md](README.md) for repository layout and local setup.
2. Review engineering standards in [`docs/standards/`](docs/standards/).
3. For security issues, follow [SECURITY.md](SECURITY.md) — do not open public
  issues.

## Workflow

1. **Pick or create an issue** describing the work.
2. **Branch** from `develop` using the [branch
  strategy](docs/standards/branch_strategy.md).
3. **Implement** changes in the appropriate top-level directory (`apps/`,
  `services/`, `packages/`, etc.).
4. **Commit** using [Conventional Commits](docs/standards/commit_convention.md).
5. **Open a pull request** against `develop` (or `main` for hotfixes) using the
  PR template.
6. **Address review feedback** — see the [code review
  checklist](docs/standards/code_review_checklist.md).

## Standards

| Topic | Document |
| ---------------- | ----------------------------------------------------- |
| Branching | [docs/standards/branch_strategy.md](docs/standards/branch_strategy.md) |
| Commits | [docs/standards/commit_convention.md](docs/standards/commit_convention.md) |
| Versioning | [docs/standards/versioning.md](docs/standards/versioning.md) |
| Code review | [docs/standards/code_review_checklist.md](docs/standards/code_review_checklist.md) |
| Architecture | [docs/adr/README.md](docs/adr/README.md) |

## Pull Request Requirements

- Descriptive title matching commit convention (e.g. `feat(services): add health
  endpoint`).
- Linked issue(s) where applicable.
- Passing CI checks (when configured).
- At least one approval from a code owner.
- No committed secrets, credentials, or `.env` files.

## Architectural Changes

Significant design decisions require an Architecture Decision Record (ADR) in
[`docs/adr/`](docs/adr/). Propose the ADR in the same PR or a preceding PR
before implementation.

## Code Style

- Follow [`.editorconfig`](.editorconfig) for formatting.
- Keep changes focused — one logical concern per PR when possible.

## Questions

Open a discussion or issue labeled `question` if workflow or standards are
unclear.

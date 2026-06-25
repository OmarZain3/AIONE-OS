# Commit Convention

AIONE follows [Conventional Commits](https://www.conventionalcommits.org/) for
all commit messages.

## Format

```text
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

| Part | Required | Rules |
| ------------- | -------- | -------------------------------------------------- |
| `type` | Yes | See allowed types below |
| `scope` | No | Component affected (e.g. `backend`, `frontend`) |
| `description` | Yes | Imperative mood, lowercase, no trailing period |
| `body` | No | Additional context, wrapped at 72 characters |
| `footer` | No | Breaking changes, issue references |

## Types

| Type | When to Use |
| ---------- | ------------------------------------------------ |
| `feat` | New feature or user-facing capability |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `refactor` | Code restructuring without behavior change |
| `test` | Adding or correcting tests |
| `build` | Build system, dependencies, or tooling |
| `ci` | CI/CD pipeline configuration |
| `perf` | Performance improvement |
| `chore` | Maintenance tasks that don't fit other types |

## Scopes

Use the monorepo top-level directory or service name:

`apps`, `services`, `packages`, `infrastructure`, `docs`, `scripts`, `tests`

Omit scope for repository-wide changes (e.g. root config).

## Examples

```text
feat(services): add health check endpoint
fix(apps): resolve login redirect loop
docs: add branch strategy guide
refactor(packages): extract shared validation utilities
test(services): add integration tests for auth middleware
build: update Docker Compose postgres image
ci: add lint workflow for pull requests
perf(services): cache database connection pool
chore: bump development dependencies
```

## Breaking Changes

Indicate breaking changes with `!` after the type/scope or in the footer:

```text
feat(services)!: remove deprecated v1 API endpoints

BREAKING CHANGE: v1 endpoints removed; migrate to v2.
```

## Issue References

```text
fix(services): correct token expiry calculation

Closes #108
```

## Rules

- One logical change per commit when possible.
- Keep the subject line ≤ 72 characters.
- Do not mix unrelated changes in a single commit.
- PR titles should match the squash-merge commit message.

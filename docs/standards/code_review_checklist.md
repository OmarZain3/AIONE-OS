# Code Review Checklist

Use this checklist for every pull request — reviewers and authors share
responsibility.

## Author (Before Requesting Review)

- [ ] PR title follows [commit convention](commit_convention.md)
- [ ] Branch name follows [branch strategy](branch_strategy.md)
- [ ] Changes are scoped to a single concern
- [ ] Self-reviewed (read the diff as a reviewer would)
- [ ] Tests added or updated for behavior changes
- [ ] Documentation updated (README, ADR, standards) if needed
- [ ] `CHANGELOG.md` updated for user-facing changes
- [ ] No secrets, `.env` files, or credentials committed
- [ ] `.editorconfig` formatting respected

## Reviewer — Correctness

- [ ] Code does what the PR description claims
- [ ] Edge cases and error paths are handled
- [ ] No obvious logic errors or regressions
- [ ] Breaking changes are documented and justified

## Reviewer — Design

- [ ] Changes belong in the correct directory (`apps/`, `services/`,
  `packages/`, etc.)
- [ ] No unnecessary abstraction or premature optimization
- [ ] Significant decisions have an ADR ([docs/adr/README.md](../adr/README.md))
- [ ] Dependencies are justified and minimal

## Reviewer — Security

- [ ] No hardcoded secrets or credentials
- [ ] Input validation at trust boundaries
- [ ] Authentication and authorization considered where applicable
- [ ] Dependencies do not introduce known critical vulnerabilities
- [ ] Sensitive data not logged or exposed in error messages

## Reviewer — Operations

- [ ] Configuration is externalized (environment variables, not hardcoded)
- [ ] Docker / infrastructure changes are backward-compatible or migration-noted
- [ ] Observability considered (logging, health checks) for service changes

## Reviewer — Tests

- [ ] Tests are meaningful (not trivial assertions)
- [ ] CI passes (when configured)
- [ ] Manual verification steps documented in PR if automation is insufficient

## Reviewer — Documentation

- [ ] Public interfaces documented
- [ ] Complex logic has inline comments only where non-obvious
- [ ] PR description includes testing evidence

## Approval Criteria

| Target Branch | Required Approvals | Code Owner Review |
| ------------- | ------------------ | ----------------- |
| `develop` | ≥ 1 | Recommended |
| `main` | ≥ 2 | Required |

## Feedback Guidelines

- Be specific, constructive, and timely.
- Distinguish **blockers** (must fix) from **suggestions** (nice to have).
- Resolve all blockers before merge.
- Authors should respond to every comment — fix, push back with rationale, or
  ask for clarification.

# 0001. Repository Strategy

## Status

**Accepted** — 2026-06-24

## Context

AIONE is an enterprise platform spanning client applications, backend services, shared libraries, and infrastructure. Teams need a single source of truth, consistent engineering standards, and coordinated releases without sacrificing service autonomy.

Options considered ranged from polyrepo (one repository per service) to a single monolithic repository. The platform is in an early foundation phase (`v0.1.0-alpha`) with multiple technology stacks (Flutter clients, Django services) planned.

## Decision

Adopt a **monorepo** hosted in a single Git repository with the following top-level layout:

| Directory         | Responsibility                                      |
| ----------------- | --------------------------------------------------- |
| `apps/`           | Client-facing applications (Flutter, web shells)    |
| `services/`       | Backend services (Django and workers)               |
| `packages/`       | Shared libraries consumed across apps and services  |
| `infrastructure/` | IaC, deployment manifests, platform configuration  |
| `docs/`           | ADRs, standards, runbooks                           |
| `scripts/`        | Repository automation and maintenance               |
| `tests/`          | Cross-cutting integration and end-to-end tests      |

Governance:

- **Branching:** Git Flow–inspired (`main`, `develop`, `feature/*`, `release/*`, `hotfix/*`) per [branch strategy](../standards/branch_strategy.md).
- **Commits:** Conventional Commits per [commit convention](../standards/commit_convention.md).
- **Versioning:** Semantic Versioning per [versioning](../standards/versioning.md).
- **CI:** Unified pipelines under `.github/workflows/` with path-aware jobs.
- **Ownership:** `CODEOWNERS` maps directories to review teams.

## Alternatives

| Alternative              | Why Not Chosen                                              |
| ------------------------ | ----------------------------------------------------------- |
| Polyrepo (per service)   | Higher coordination cost, duplicated standards, drift risk  |
| Monolith (single app dir)| Poor separation of concerns; blocks independent scaling     |
| Meta-repo (submodules)   | Complex developer experience; version pinning overhead        |
| Trunk-based only         | Deferred — Git Flow better suits staged releases at alpha   |

## Consequences

### Positive

- Single CI/CD and standards enforcement point.
- Atomic cross-cutting changes (API contract + client + docs) in one PR.
- Shared packages versioned with consumers — no publish lag.
- Onboarding simplified: one clone, one `Makefile`, one compose file.

### Negative

- Repository size and CI duration grow with codebase.
- Requires disciplined path-based CI to avoid unnecessary job runs.
- CODEOWNERS and review load concentrated on maintainers early on.

### Neutral

- Tooling investment (pre-commit, matrix discovery) required upfront.
- Teams must learn monorepo conventions before contributing application code.

## Future Review

Revisit when **any** of the following occur:

- Repository exceeds ~50 active contributors with frequent merge conflicts.
- CI wall-clock time consistently exceeds 15 minutes on typical PRs.
- A service requires independent release cadence incompatible with monorepo tagging.
- Legal or compliance mandates physical isolation of components.

**Next review date:** 2026-12-24 (or upon first production release, whichever is sooner).

# Release Plan

Release strategy for AIONE per [versioning](../docs/standards/versioning.md) and
[branch strategy](../docs/standards/branch_strategy.md).

**Current version:** `v0.1.0-alpha` · **Next target:** `v0.2.0-beta`

## Release Train

| Release | Branch | Base | Tag | Theme |
| ------- | ------ | ---- | --- | ----- |
| `v0.1.0-alpha` | `main` | — | `v0.1.0-alpha` | Foundation ✓ |
| `v0.2.0-beta` | `release/v0.2.0` | `develop` | `v0.2.0-beta` | Scaffold |
| `v0.3.0-alpha` | `release/v0.3.0` | `develop` | `v0.3.0-alpha` | Generators |
| `v0.3.0-beta` | `release/v0.3.0` | `develop` | `v0.3.0-beta` | Graph + pkgs |
| `v0.4.0-beta` | `release/v0.4.0` | `develop` | `v0.4.0-beta` | Product beta |

Pre-1.0: breaking changes permitted in `MINOR` per versioning standard.

## v0.2.0-beta — Integrated Scaffold

**Target:** 2026-07 · **Phase:** 1

### Scope (in)

- `services/backend` — health, auth, OpenAPI
- `apps/founder_studio` — auth UI, health integration, i18n
- Docker Compose full stack (`--profile app`)
- CI green on `main` and `develop`
- Documentation reconciliation (TD-001, TD-002, TD-003)
- Cross-stack E2E smoke test (BL-018)

### Scope (out)

- `definitions/` and generators (v0.3.0-alpha)
- `graph.yaml` (v0.3.0-beta)
- Production deployment
- Founder Studio project CRUD

### Release Checklist

1. [ ] All P0 backlog items for Phase 1 closed
2. [ ] Critical tech debt resolved (TD-001, TD-002)
3. [ ] `make ci` passes locally
4. [ ] `docker compose --profile app up` — all services healthy
5. [ ] Move `[Unreleased]` → `[0.2.0-beta]` in CHANGELOG.md
6. [ ] Branch `release/v0.2.0` from `develop`
7. [ ] Version bumps: `founder_studio` pubspec if needed
8. [ ] PR `release/v0.2.0` → `main` (merge commit)
9. [ ] Tag `v0.2.0-beta` on `main`; push tag
10. [ ] Merge `main` back to `develop`
11. [ ] Delete `release/v0.2.0` branch

### Rollback

- Revert merge commit on `main`; retag previous `v0.1.0-alpha` if needed.
- Compose volumes are dev-only; no migration rollback required.

## v0.3.0-alpha — Generator Pipeline

**Target:** 2026-08 · **Phase:** 2

### Scope (in) — v0.3.0-alpha

- `definitions/`, `scripts/generators/`, `make generate`
- CI drift check
- Migrate auth/health contracts to generated artifacts

### Gate

- ADR 0004 Future Review criteria met for first generator CI run.

## Release Roles

| Role | Responsibility |
| ---- | -------------- |
| Release manager | Branch cut, checklist, tag |
| Code owners | Approve `main` merge (≥ 2 reviews) |
| CI | All workflows green on release branch |
| Docs | CHANGELOG, version refs, planning ledger update |

## Communication

| Audience | Channel | When |
| -------- | ------- | ---- |
| Contributors | CHANGELOG + `planning/execution_ledger.md` | On tag |
| Stakeholders | Release notes (GitHub Release) | On tag |
| Security | SECURITY.md version table | On tag |

## Hotfix Process

Per [branch strategy](../docs/standards/branch_strategy.md):

1. Branch `hotfix/<id>-description` from `main`
2. Fix + test + CHANGELOG patch entry
3. PR → `main` (merge commit); tag `v0.x.Y`
4. Cherry-pick or merge back to `develop`

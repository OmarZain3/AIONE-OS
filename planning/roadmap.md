# Roadmap

High-level delivery timeline for AIONE. Aligned with [Semantic
Versioning](../docs/standards/versioning.md) and [branch
strategy](../docs/standards/branch_strategy.md).

**Current:** `v0.1.0-alpha` (foundation) · **Target:** `v0.2.0-beta` (integrated
scaffold)

## Phases

```text
Phase 0 ──► Phase 1 ──► Phase 2 ──► Phase 3 ──► Phase 4
Foundation   Scaffold     Generators   Graph+Pkgs   Product Beta
  ✓            ~90%          planned       planned       planned
```

### Phase 0 — Foundation (`v0.1.0-alpha`) ✓

**Window:** 2026-06 · **Status:** Complete

- Monorepo layout, standards, ADRs 0001–0005
- CI/CD, pre-commit, Docker Compose (postgres, redis)
- Tagged `v0.1.0-alpha` on `main`

### Phase 1 — Application Scaffold (`v0.2.0-beta`)

**Window:** 2026-06 → 2026-07 · **Status:** In progress (~90%)

| Deliverable | Component | ADR |
| ----------- | --------- | --- |
| Django backend with health + auth | `service:backend` | 0003 |
| Flutter Founder Studio client | `app:founder_studio` | 0002 |
| Full-stack Compose (`--profile app`) | docker-compose | 0001 |
| OpenAPI at `/api/schema/` | backend | 0003 |
| Documentation reconciliation | docs, CHANGELOG | 0001 |

**Exit criteria:** `docker compose --profile app up` healthy; CI green; E2E
smoke test passes; docs reflect reality.

### Phase 2 — Generator Pipeline (`v0.3.0-alpha`)

**Window:** 2026-07 → 2026-08 · **Status:** Planned

| Deliverable | ADR |
| ----------- | --- |
| `definitions/` canonical schemas | 0004 |
| `scripts/generators/` + `make generate` | 0004 |
| CI drift enforcement | 0004 |
| Auth/health contract migration | 0004 |

**Exit criteria:** First generator runs in CI; zero hand-edited generated files.

### Phase 3 — Knowledge Graph & Packages (`v0.3.0-beta`)

**Window:** 2026-08 → 2026-09 · **Status:** Planned

| Deliverable | ADR |
| ----------- | --- |
| `docs/knowledge-graph/graph.yaml` | 0005 |
| Entity registration for apps/services | 0005 |
| Shared `packages/` API client | 0001, 0004 |
| `CODEOWNERS` enforcement | 0001 |

**Exit criteria:** Graph CI validates; all apps/services registered; shared
package consumed by client.

### Phase 4 — Product Beta (`v0.4.0-beta`)

**Window:** 2026-09+ · **Status:** Planned

- Founder Studio project management (CRUD)
- Staging infrastructure (`infrastructure/`)
- Observability baseline
- Wider internal beta

**Exit criteria:** Feature-complete for internal beta; staging deploy automated.

## Milestone Map

| Version | Phase | Theme |
| ------- | ----- | ----- |
| `v0.1.0-alpha` | 0 | Foundation |
| `v0.2.0-beta` | 1 | Integrated scaffold |
| `v0.3.0-alpha` | 2 | Generator pipeline |
| `v0.3.0-beta` | 3 | Graph + shared packages |
| `v0.4.0-beta` | 4 | Product beta |
| `v1.0.0` | — | Production GA (TBD) |

## ADR Review Triggers

Per ADR Future Review clauses — schedule reviews when:

| ADR | Trigger |
| --- | ------- |
| 0001 | First production release or 2026-12-24 |
| 0002 | First production Flutter ship or post-scaffold sprint |
| 0003 | First production Django deploy or post-scaffold sprint |
| 0004 | `definitions/` introduction (Sprint 003+) |
| 0005 | `graph.yaml` introduction (Sprint 003+) |

## Out of Scope (Current Horizon)

- Multi-service decomposition beyond `services/backend`
- Celery / event-driven patterns (deferred per ADR 0003)
- Graph database or documentation portal (deferred per ADR 0005)
- Native Swift/Kotlin clients (deferred per ADR 0002)

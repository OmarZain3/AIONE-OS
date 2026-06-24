# Master Backlog

Prioritized work items for AIONE. Governed by [ADR 0001](../docs/adr/0001-repository-strategy.md) (monorepo), [ADR 0002](../docs/adr/0002-flutter-architecture.md), [ADR 0003](../docs/adr/0003-django-architecture.md), [ADR 0004](../docs/adr/0004-generator-driven-development.md), and [ADR 0005](../docs/adr/0005-knowledge-graph.md).

**Version:** `v0.1.0-alpha` · **Last updated:** 2026-06-24

## Priority Legend

| Priority | Meaning |
| -------- | ------- |
| P0 | Blocks release or CI; do now |
| P1 | Required for next milestone |
| P2 | Important; schedule after P1 |
| P3 | Defer until dependency met |

## Epics

### E1 — Platform Foundation (complete)

| ID | Item | Priority | Status | ADR / Standard |
| -- | ---- | -------- | ------ | -------------- |
| BL-001 | Monorepo layout and root config | P0 | Done | ADR 0001 |
| BL-002 | Engineering standards and ADRs 0001–0005 | P0 | Done | ADR 0001 |
| BL-003 | CI/CD (pre-commit, docs, Flutter, Django) | P0 | Done | ADR 0001 |
| BL-004 | Local infra (PostgreSQL, Redis via Compose) | P0 | Done | ADR 0003 |

### E2 — Application Scaffold

| ID | Item | Priority | Status | ADR / Standard |
| -- | ---- | -------- | ------ | -------------- |
| BL-010 | Django backend scaffold (`services/backend`) | P0 | Done | ADR 0003 |
| BL-011 | Health API + OpenAPI (`drf-spectacular`) | P0 | Done | ADR 0003 |
| BL-012 | Accounts/auth domain (models, services, API) | P1 | Done | ADR 0003 |
| BL-013 | Backend Dockerfile + Compose `app` profile | P1 | Done | ADR 0003 |
| BL-014 | Flutter `founder_studio` clean-architecture scaffold | P0 | Done | ADR 0002 |
| BL-015 | Client auth flow (login, tokens, secure storage) | P1 | Done | ADR 0002 |
| BL-016 | Client health integration + connection status | P1 | Done | ADR 0002 |
| BL-017 | Flutter Dockerfile + Compose integration | P1 | Done | ADR 0002 |
| BL-018 | Cross-stack E2E smoke test (`tests/`) | P1 | Open | ADR 0001 |
| BL-019 | Reconcile root README and CHANGELOG with scaffold state | P1 | Open | versioning |
| BL-020 | `founder_studio` README (replace Flutter template) | P2 | Open | ADR 0002 |
| BL-021 | `CODEOWNERS` directory ownership map | P2 | Open | ADR 0001 |

### E3 — Generator Pipeline

| ID | Item | Priority | Status | ADR / Standard |
| -- | ---- | -------- | ------ | -------------- |
| BL-030 | Introduce `definitions/` (OpenAPI, models, config) | P1 | Open | ADR 0004 |
| BL-031 | Generator scripts under `scripts/generators/` | P1 | Open | ADR 0004 |
| BL-032 | `make generate` orchestration target | P1 | Open | ADR 0004 |
| BL-033 | CI drift check (definitions vs generated output) | P1 | Open | ADR 0004 |
| BL-034 | Migrate hand-written auth/health contracts to generated | P2 | Open | ADR 0004 |
| BL-035 | Commit policy for `generated/` artifacts | P2 | Open | ADR 0004 |

### E4 — Knowledge Graph

| ID | Item | Priority | Status | ADR / Standard |
| -- | ---- | -------- | ------ | -------------- |
| BL-040 | `docs/knowledge-graph/graph.yaml` (Phase 2) | P2 | Open | ADR 0005 |
| BL-041 | CI validation (orphans, schema) | P2 | Open | ADR 0005 |
| BL-042 | Register `app:founder_studio`, `service:backend` entities | P2 | Open | ADR 0005 |
| BL-043 | Auto-discovery from dependency graphs (Phase 3) | P3 | Open | ADR 0005 |

### E5 — Shared Packages

| ID | Item | Priority | Status | ADR / Standard |
| -- | ---- | -------- | ------ | -------------- |
| BL-050 | `packages/` layout and publishing policy | P2 | Open | ADR 0001, 0004 |
| BL-051 | Shared API client package (post-generator) | P2 | Open | ADR 0002, 0004 |

### E6 — Infrastructure & Operations

| ID | Item | Priority | Status | ADR / Standard |
| -- | ---- | -------- | ------ | -------------- |
| BL-060 | `infrastructure/` IaC scaffold (staging) | P2 | Open | ADR 0001 |
| BL-061 | Production secrets manager integration | P2 | Open | SECURITY.md |
| BL-062 | Observability baseline (structured logging, metrics) | P2 | Open | ADR 0003 |
| BL-063 | Replace placeholder security contact | P1 | Open | SECURITY.md |

### E7 — Product (Founder Studio)

| ID | Item | Priority | Status | ADR / Standard |
| -- | ---- | -------- | ------ | -------------- |
| BL-070 | Project CRUD domain (backend + client) | P2 | Open | ADR 0002, 0003 |
| BL-071 | Role-based permissions (extend accounts) | P2 | Open | ADR 0003 |
| BL-072 | Integration tests for auth flows | P2 | Open | ADR 0002 |

## Backlog Hygiene

- New items: append with next `BL-NNN` ID; link ADR or standard.
- Status values: `Open`, `In Progress`, `Done`, `Deferred`, `Cancelled`.
- P0 items must have an owner before sprint start.
- User-facing changes require `CHANGELOG.md` entry per [versioning](../docs/standards/versioning.md).

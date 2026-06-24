# 0003. Django Architecture

## Status

**Accepted** — 2026-06-24

## Context

AIONE backend services require a mature, batteries-included Python framework with strong ORM, admin, and ecosystem support. Django is the chosen stack for services under `services/` per the monorepo layout defined in [ADR 0001](0001-repository-strategy.md).

An architectural baseline is needed before service code is introduced — covering project structure, layering, settings management, and CI — without defining business domains or API endpoints.

## Decision

### Placement

- Each Django service is a self-contained project at `services/<service-name>/`.
- Shared Python libraries live under `packages/<package-name>/`.
- Each service owns a `manage.py` at its project root.

### Layered Architecture

```
config/           → settings, URLs, WSGI/ASGI (project shell)
apps/<domain>/    → Django apps per bounded context
  models.py       → data models (persistence layer)
  services/       → business logic (framework-agnostic where possible)
  selectors/      → read/query logic (optional, for complex reads)
  api/            → serializers, views, routers (transport layer)
```

**Rules:**

1. Business logic resides in `services/`, not in views or serializers.
2. Views are thin — validate input, call service, return response.
3. Cross-service communication uses explicit contracts (HTTP/events), not shared database tables.
4. Settings split: `config/settings/base.py`, `development.py`, `production.py`, `test.py`.

### API Style

- Default transport: **Django REST Framework** (DRF) when HTTP APIs are introduced.
- OpenAPI schema generation via `drf-spectacular` (configured during service scaffold sprint).
- No API endpoints are defined in this ADR — only structural intent.

### Data & Infrastructure

- PostgreSQL as primary datastore (via Docker Compose locally).
- Redis for caching and ephemeral data (via Docker Compose locally).
- Environment-driven configuration — no secrets in code (`.env.example` template).

### CI Integration

- Discovered via `manage.py` under `services/` and `packages/`.
- Pipeline: Ruff lint/format → `manage.py check` → `manage.py test` (`.github/workflows/django.yml`).
- Local parity via `make django-check` and pre-commit hooks.

## Alternatives

| Alternative              | Why Not Chosen                                        |
| ------------------------ | ----------------------------------------------------- |
| FastAPI-only services    | Django ORM, admin, and auth ecosystem fit enterprise needs |
| Microservice per repo    | Conflicts with monorepo strategy (ADR 0001)           |
| Fat models / fat views   | Harder to test; violates separation of concerns       |
| GraphQL default          | REST + OpenAPI sufficient for initial platform phase  |
| Shared database across services | Violates service boundary isolation             |

## Consequences

### Positive

- Consistent service structure across all Django projects.
- Testable business logic isolated from HTTP transport.
- CI auto-discovers services — no per-service workflow files.
- Settings modularization supports dev/staging/prod cleanly.

### Negative

- DRF + Django layering adds ceremony for simple CRUD endpoints.
- Contributors must understand service/selector patterns.
- `manage.py check --deploy` may require tuning per service settings.

### Neutral

- Async views (Django 5+) available but not mandated until performance profiling warrants.
- Event-driven patterns (Celery, outbox) deferred to a future ADR.

## Future Review

Revisit when:

- First production Django service deploys.
- Service count exceeds 5 with shared authentication requirements.
- Performance benchmarks indicate async or alternative ORM patterns are needed.
- Event-driven architecture replaces synchronous HTTP for core flows.

**Next review date:** Upon completion of the first `services/` scaffold sprint.

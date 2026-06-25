# AIONE

Enterprise monorepo for the AIONE platform — **v0.1.0-alpha**.

> **Status:** Alpha freeze — Django backend, Founder Studio (Flutter) client,
> and local Docker runtime are implemented. Generator pipeline, knowledge graph
> artifacts, and production infrastructure are planned for later phases.

---

## Table of Contents

- [Repository Structure](#repository-structure)
- [Implemented Modules](#implemented-modules)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Environment Configuration](#environment-configuration)
- [Docker Compose](#docker-compose)
- [Local Development (without Docker)](#local-development-without-docker)
- [API Overview](#api-overview)
- [Development Conventions](#development-conventions)
- [Contributing](#contributing)

---

## Repository Structure

```text
AIONE/
├── apps/
│   └── founder_studio/   # Flutter client (Founder Studio)
├── services/
│   └── backend/          # Django REST API
├── docs/                 # ADRs and engineering standards
├── planning/             # Roadmap, backlog, and release planning
├── packages/             # Shared libraries (reserved)
├── infrastructure/       # IaC and deployment manifests (reserved)
├── scripts/              # Automation scripts (reserved)
├── tests/                # Cross-cutting E2E tests (reserved)
├── .editorconfig
├── .env.example
├── docker-compose.yml
└── README.md
```

| Directory | Purpose |
| --------- | ------- |
| `apps/founder_studio/` | Flutter client (web, mobile, desktop) |
| `services/backend/` | Django REST API (auth, health, projects) |
| `docs/` | Architecture Decision Records (ADRs) and coding standards |
| `planning/` | Roadmap, backlog, technical debt, and release planning |
| `packages/` | Shared modules/SDKs (scaffold) |
| `infrastructure/` | IaC and CI/CD assets (scaffold) |
| `scripts/` | Automation scripts (scaffold) |
| `tests/` | Cross-repo E2E tests (scaffold) |

---

## Implemented Modules

### Backend (`services/backend`)

- **Health** — `GET /api/health/` (public)
- **Authentication** — JWT login, refresh, verify, logout, and `/api/auth/me/`
- **Projects** — CRUD for founder venture projects (`/api/projects/`)
- **API docs** — OpenAPI schema at `/api/schema/`, Swagger UI at `/api/docs/`

### Founder Studio (`apps/founder_studio`)

Flutter client using clean architecture (presentation → application → domain →
infrastructure):

- Email/password login with secure token storage and session restore
- Project dashboard with create, view, edit, and delete
- Backend connection status and version display
- Light/dark/system theme and English/Arabic localization

---

## Prerequisites

| Tool | Minimum Version | Purpose |
| --------------- | --------------- | -------------------------------- |
| [Git](https://git-scm.com/) | 2.30+ | Version control |
| [Docker](https://www.docker.com/) | 24+ | Container runtime (optional) |
| [Docker Compose](https://docs.docker.com/compose/) | v2.20+ | Local orchestration |
| [Python](https://www.python.org/) | 3.12+ | Backend development |
| [Flutter](https://docs.flutter.dev/) | 3.11+ | Founder Studio development |

---

## Getting Started

1. **Clone the repository**

   ```bash
   git clone https://github.com/aione/aione.git AIONE
   cd AIONE
   ```

2. **Configure environment variables**

   ```bash
   cp .env.example .env
   ```

   Edit `.env` and set strong values for `APP_SECRET_KEY` and
`POSTGRES_PASSWORD` before any shared or production use.

3. **Start infrastructure services**

   ```bash
   docker compose up -d postgres redis
   ```

4. **Verify services are healthy**

   ```bash
   docker compose ps
   ```

   Both `postgres` and `redis` should report a `healthy` status.

5. **Run the application** — see [Local
  Development](#local-development-without-docker) or start the full Docker
  stack below.

---

## Environment Configuration

All runtime configuration is driven by environment variables. The canonical
template lives in [`.env.example`](.env.example).

| Variable | Default | Description |
| --- | --- | --- |
| `COMPOSE_PROJECT_NAME` | `aione` | Docker Compose project and network prefix |
| `APP_ENV` | `development` | Runtime env: development, staging, production |
| `APP_DEBUG` | `true` | Verbose diagnostics (disable in production) |
| `APP_SECRET_KEY` | — | Application signing/encryption secret |
| `BACKEND_PORT` | `8000` | Backend service host port |
| `FRONTEND_PORT` | `3000` | Founder Studio web host port |
| `POSTGRES_*` | — | PostgreSQL connection parameters |
| `REDIS_*` | — | Redis connection parameters |
| `DATABASE_URL` | — | Full PostgreSQL connection string |
| `REDIS_URL` | — | Full Redis connection string |
| `JWT_ACCESS_TOKEN_LIFETIME_MINUTES` | `30` | JWT access token lifetime |
| `JWT_REFRESH_TOKEN_LIFETIME_DAYS` | `7` | JWT refresh token lifetime |

> **Security:** Never commit `.env` files. Real secrets belong in a secrets
> manager for non-local environments.

---

## Docker Compose

The [`docker-compose.yml`](docker-compose.yml) file defines four services:

| Service | Build Context | Port | Profile | Status |
| --- | --- | --- | --- | --- |
| `postgres` | `postgres:16-alpine` | 5432 | — | Ready |
| `redis` | `redis:7-alpine` | 6379 | — | Ready |
| `backend` | `./services/backend` | 8000 | `app` | Ready |
| `frontend` | `./apps/founder_studio` | 3000 | `app` | Ready |

> The Compose service is named `frontend` for port/env consistency; the
> application source lives in `apps/founder_studio/`.

### Infrastructure only

```bash
docker compose up -d postgres redis
```

### Full stack

```bash
docker compose --profile app up -d
```

This builds and starts the Django backend and Founder Studio web client. The
backend healthcheck calls `GET /api/health/`.

### Common commands

```bash
# View logs
docker compose logs -f postgres redis

# Stop all services
docker compose down

# Stop and remove volumes (destructive — deletes local DB data)
docker compose down -v
```

---

## Local Development (without Docker)

### Backend

```bash
cd services/backend
pip install -r requirements.txt
python manage.py migrate
python manage.py runserver
```

API documentation: <http://localhost:8000/api/docs/>

### Founder Studio

```bash
cd apps/founder_studio
flutter pub get
flutter run -d chrome --dart-define=BACKEND_URL=http://localhost:8000
```

### Tests

```bash
# Backend
cd services/backend && python manage.py test

# Founder Studio
cd apps/founder_studio && flutter analyze && flutter test
```

---

## API Overview

| Method | Endpoint | Auth | Description |
| ------ | --------------------- | ------- | ------------------------ |
| GET | `/api/health/` | Public | Service health and version |
| POST | `/api/auth/login/` | Public | Obtain JWT token pair |
| POST | `/api/auth/refresh/` | Public | Refresh access token |
| POST | `/api/auth/verify/` | Public | Verify token validity |
| POST | `/api/auth/logout/` | JWT | Blacklist refresh token |
| GET | `/api/auth/me/` | JWT | Current user profile |
| GET | `/api/projects/` | JWT | List projects |
| POST | `/api/projects/` | JWT | Create project |
| GET | `/api/projects/{id}/` | JWT | Retrieve project |
| PUT/PATCH | `/api/projects/{id}/` | JWT | Update project |
| DELETE | `/api/projects/{id}/` | JWT | Delete project |

User accounts are created via Django admin or migrations in alpha; there is no
public registration endpoint.

---

## Development Conventions

- **Line endings:** LF (enforced via [`.editorconfig`](.editorconfig))
- **Indentation:** 2 spaces (4 for Python)
- **Secrets:** Use `.env` locally; never commit credentials
- **Overrides:** Use `docker-compose.override.yml` for personal local tweaks
  (git-ignored)
- **Branching:** See
  [docs/standards/branch_strategy.md](docs/standards/branch_strategy.md)
- **Architecture:** See [docs/adr/README.md](docs/adr/README.md)

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for workflow, standards, and pull request
requirements.

---

## License

License terms to be determined by the project maintainers.

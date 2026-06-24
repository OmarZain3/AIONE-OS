# AIONE

Enterprise monorepo foundation for the AIONE platform. This repository provides the structural scaffolding, local development tooling, and operational conventions required before application code is introduced.

> **Status:** Foundation phase — directory layout and infrastructure placeholders are in place. Application services are not yet implemented.

---

## Table of Contents

- [Repository Structure](#repository-structure)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Environment Configuration](#environment-configuration)
- [Docker Compose](#docker-compose)
- [Development Conventions](#development-conventions)
- [Contributing](#contributing)

---

## Repository Structure

```
AIONE/
├── apps/              # Client-facing applications (web, mobile shells, etc.)
├── docs/              # Architecture decisions, runbooks, and project documentation
├── infrastructure/    # IaC, deployment manifests, and platform configuration
├── packages/          # Shared libraries consumed across services and apps
├── scripts/           # Automation, bootstrap, and maintenance scripts
├── services/          # Backend services and APIs
├── tests/             # Cross-cutting integration and end-to-end tests
├── .editorconfig      # Editor formatting rules
├── .env.example       # Environment variable template
├── .gitignore         # VCS exclusion rules
├── docker-compose.yml # Local development orchestration
└── README.md          # This file
```

| Directory         | Purpose                                                                 |
| ----------------- | ----------------------------------------------------------------------- |
| `apps/`           | User-facing applications deployed independently or as part of the stack |
| `docs/`           | Living documentation, ADRs, and operational guides                      |
| `infrastructure/` | Terraform, Kubernetes manifests, CI/CD pipelines, and cloud resources   |
| `packages/`       | Reusable modules, SDKs, and shared configuration                        |
| `scripts/`        | One-off and recurring automation tasks                                  |
| `services/`       | Server-side services, workers, and background processors                |
| `tests/`          | Repository-level test suites that span multiple components              |

---

## Prerequisites

| Tool            | Minimum Version | Purpose                          |
| --------------- | --------------- | -------------------------------- |
| [Git](https://git-scm.com/)           | 2.30+           | Version control                  |
| [Docker](https://www.docker.com/)     | 24+             | Container runtime                |
| [Docker Compose](https://docs.docker.com/compose/) | v2.20+ | Local orchestration |

---

## Getting Started

1. **Clone the repository**

   ```bash
   git clone <repository-url> AIONE
   cd AIONE
   ```

2. **Configure environment variables**

   ```bash
   cp .env.example .env
   ```

   Edit `.env` and replace placeholder values (especially `APP_SECRET_KEY` and `POSTGRES_PASSWORD`).

3. **Start infrastructure services**

   ```bash
   docker compose up -d postgres redis
   ```

4. **Verify services are healthy**

   ```bash
   docker compose ps
   ```

   Both `postgres` and `redis` should report a `healthy` status.

---

## Environment Configuration

All runtime configuration is driven by environment variables. The canonical template lives in [`.env.example`](.env.example).

| Variable            | Default       | Description                              |
| ------------------- | ------------- | ---------------------------------------- |
| `COMPOSE_PROJECT_NAME` | `aione`    | Docker Compose project and network prefix |
| `APP_ENV`           | `development` | Runtime environment (`development`, `staging`, `production`) |
| `APP_DEBUG`         | `true`        | Enable verbose diagnostics (disable in production) |
| `APP_SECRET_KEY`    | —             | Application signing/encryption secret    |
| `BACKEND_PORT`      | `8000`        | Backend service host port                |
| `FRONTEND_PORT`     | `3000`        | Frontend application host port           |
| `POSTGRES_*`        | —             | PostgreSQL connection parameters         |
| `REDIS_*`           | —             | Redis connection parameters              |
| `DATABASE_URL`      | —             | Full PostgreSQL connection string        |
| `REDIS_URL`         | —             | Full Redis connection string             |

> **Security:** Never commit `.env` files. Real secrets belong in a secrets manager for non-local environments.

---

## Docker Compose

The [`docker-compose.yml`](docker-compose.yml) file defines four services:

| Service    | Image / Build Context      | Default Port | Profile | Status        |
| ---------- | -------------------------- | ------------ | ------- | ------------- |
| `postgres` | `postgres:16-alpine`       | 5432         | —       | Ready         |
| `redis`    | `redis:7-alpine`           | 6379         | —       | Ready         |
| `backend`  | `./services/backend`       | 8000         | `app`   | Placeholder   |
| `frontend` | `./apps/frontend`          | 3000         | `app`   | Placeholder   |

### Infrastructure only (available now)

```bash
docker compose up -d postgres redis
```

### Full stack (requires Dockerfiles)

Application services are gated behind the `app` profile until their respective Dockerfiles are added:

- `services/backend/Dockerfile`
- `apps/frontend/Dockerfile`

```bash
docker compose --profile app up -d
```

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

## Development Conventions

- **Line endings:** LF (enforced via [`.editorconfig`](.editorconfig))
- **Indentation:** 2 spaces (4 for Python)
- **Secrets:** Use `.env` locally; never commit credentials
- **Overrides:** Use `docker-compose.override.yml` for personal local tweaks (git-ignored)
- **Branching:** Follow your team's Git workflow; feature branches off `main` recommended

---

## Contributing

1. Create a feature branch from `main`.
2. Make changes within the appropriate top-level directory.
3. Ensure `.editorconfig` rules are respected.
4. Open a pull request with a clear description of intent and scope.

---

## License

License terms to be determined by the project maintainers.

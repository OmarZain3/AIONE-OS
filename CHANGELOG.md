# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/) as
defined in
[docs/standards/versioning.md](docs/standards/versioning.md).

## [Unreleased]

_No changes yet._

## [0.1.0-alpha] - 2026-06-24

### Added

- Initial monorepo scaffolding: `apps/`, `services/`, `packages/`,
  `infrastructure/`, `docs/`, `scripts/`, `tests/`.
- Local development infrastructure: PostgreSQL and Redis via Docker Compose.
- Root configuration: `.editorconfig`, `.gitignore`, `.env.example`.
- Enterprise engineering standards (contributing guide, security policy, ADRs,
  coding standards).
- **Founder Studio** (`apps/founder_studio`) — Flutter client with clean
  architecture, GoRouter navigation, Riverpod state, EN/AR localization, and
  light/dark theme.
- **Authentication** — JWT-based auth on the Django backend (login, refresh,
  verify, logout, `/api/auth/me/`); secure token storage and session restore in
  Founder Studio.
- **Project CRUD** — Founder venture projects API (`/api/projects/`) with
  status, color, and icon metadata; full list/create/view/edit/delete flow in
  Founder Studio.
- **Alpha runtime** — Docker Compose `app` profile for backend
  (`services/backend/Dockerfile`) and Founder Studio web build
  (`apps/founder_studio/Dockerfile`); health endpoints and service healthchecks
  for orchestration.

[Unreleased]: https://github.com/aione/aione/compare/v0.1.0-alpha...HEAD
[0.1.0-alpha]: https://github.com/aione/aione/releases/tag/v0.1.0-alpha

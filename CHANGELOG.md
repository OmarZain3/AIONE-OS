# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/) as defined in
[docs/standards/versioning.md](docs/standards/versioning.md).

## [Unreleased]

### Added

- Repository foundation (monorepo layout, Docker Compose, environment templates).
- Enterprise engineering standards (contributing guide, security policy, ADRs, coding standards).

## [0.1.0-alpha] - 2026-06-24

### Added

- Initial monorepo scaffolding: `apps/`, `services/`, `packages/`, `infrastructure/`, `docs/`, `scripts/`, `tests/`.
- Local development infrastructure: PostgreSQL and Redis via Docker Compose.
- Root configuration: `.editorconfig`, `.gitignore`, `.env.example`.

[Unreleased]: https://github.com/aione/aione/compare/v0.1.0-alpha...HEAD
[0.1.0-alpha]: https://github.com/aione/aione/releases/tag/v0.1.0-alpha

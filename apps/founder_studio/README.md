# Founder Studio

Flutter client for the AIONE platform — founder dashboard, authentication, and
project management.

**Version:** `0.1.0-alpha` (see `lib/core/constants.dart`)

## Architecture

Clean architecture layers under `lib/`:

| Layer | Path | Role |
| ----- | ---- | ---- |
| `presentation/` | pages, widgets, router, shell | UI and navigation |
| `application/` | Riverpod providers | State and use-case orchestration |
| `domain/` | entities, repo interfaces | Business models (no Flutter) |
| `infrastructure/` | API clients, repo impls | HTTP and secure storage |

See [ADR 0002](../../docs/adr/0002-flutter-architecture.md) for the full
architectural baseline.

## Prerequisites

- Flutter SDK `^3.11.4` (see `pubspec.yaml`)
- Running AIONE backend at `http://localhost:8000` (or set `BACKEND_URL`)

## Getting Started

```bash
flutter pub get
flutter run -d chrome --dart-define=BACKEND_URL=http://localhost:8000
```

## Tests

```bash
flutter analyze
flutter test
```

## Localization

English and Arabic strings live in `lib/l10n/`. Regenerate after ARB edits:

```bash
flutter gen-l10n
```

## Docker

The web build is containerized for Compose (`Dockerfile`). The Compose service
is named `frontend`; source lives in this directory.

# 0002. Flutter Architecture

## Status

**Accepted** — 2026-06-24

## Context

AIONE requires cross-platform client applications. Flutter provides a single
codebase for mobile and desktop targets with strong widget tooling and test
support. The monorepo places client apps under `apps/` per [ADR
0001](0001-repository-strategy.md).

We need an architectural baseline before application code is introduced —
covering project placement, layering, dependency rules, and CI integration —
without prescribing business features.

## Decision

### Placement

- All Flutter applications live under `apps/<app-name>/`.
- Shared Dart/Flutter libraries live under `packages/<package-name>/`.
- Each Flutter project owns a `pubspec.yaml` at its root.

### Layered Architecture

Each app follows **clean architecture** with unidirectional dependencies:

```text
presentation/   → UI, widgets, state management
application/    → use cases, orchestration
domain/         → entities, repository interfaces (no Flutter imports)
infrastructure/ → API clients, local storage, platform adapters
```

### Rules

1. `domain/` must not import from `presentation/`, `application/`, or
  `infrastructure/`.
2. `presentation/` must not import from `infrastructure/` directly — go through
  `application/`.
3. Shared code used by 2+ apps belongs in `packages/`, not duplicated.

### State Management

- Default: **Riverpod** for dependency injection and reactive state.
- Alternatives per-app require an ADR amendment.

### Testing Strategy

| Layer | Test Type |
| -------------- | ---------------- |
| `domain/` | Unit tests |
| `application/` | Unit tests |
| `presentation/` | Widget tests |
| Full flows | Integration tests in `integration_test/` |

### CI Integration

- Discovered via `pubspec.yaml` under `apps/` and `packages/`.
- Pipeline: `dart format` → `flutter analyze` → `flutter test`
  (`.github/workflows/flutter.yml`).
- Local parity via `make flutter-analyze` and pre-commit hooks.

## Alternatives

| Alternative | Why Not Chosen |
| --- | --- |
| React Native | Flutter cross-platform UI |
| BLoC only | Riverpod offers simpler DI with comparable testability |
| Feature-first folders | Layer-first enforces dependency boundaries |
| Separate Flutter repo | Conflicts with monorepo strategy (ADR 0001) |

## Consequences

### Positive

- Clear boundaries reduce coupling and ease testing.
- CI auto-discovers projects — no workflow edits per new app.
- Shared packages promote reuse without external publishing.

### Negative

- Clean architecture adds boilerplate for simple screens.
- Riverpod learning curve for contributors unfamiliar with the pattern.
- Flutter SDK required locally for full pre-commit parity.

### Neutral

- Code generation (see [ADR 0004](0004-generator-driven-development.md)) will
  integrate at the `domain/` and `infrastructure/` boundaries.
- Web-specific concerns may require a dedicated `apps/web/` variant later.

## Future Review

Revisit when:

- First production Flutter app ships to end users.
- State management pain points emerge at scale (memory, rebuilds).
- A second client framework (e.g. native Swift/Kotlin) is proposed.
- Package count in `packages/` exceeds 10 shared libraries.

**Next review date:** Upon completion of the first `apps/` scaffold sprint.

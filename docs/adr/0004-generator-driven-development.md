# 0004. Generator-Driven Development

## Status

**Accepted** — 2026-06-24

## Context

AIONE spans Flutter clients and Django services with shared contracts (API
schemas, data models, configuration). Manual duplication across stacks
introduces drift, review burden, and defect risk — especially as the platform
scales beyond the foundation phase.

The team needs a strategy for **code generation** from canonical definitions
before application sprints begin, aligned with the architectures in [ADR
0002](0002-flutter-architecture.md) and [ADR 0003](0003-django-architecture.md).

## Decision

Adopt **generator-driven development** where machine-readable definitions are
the source of truth and target-language artifacts are generated, never
hand-edited.

### Source-of-Truth Hierarchy

```text
definitions/          → canonical schemas (introduced in a future sprint)
  openapi/            → API contracts
  models/             → shared data model definitions
  config/             → environment and feature flag schemas

generated/            → output dirs (git-ignored or committed)
```

> **Note:** `definitions/` directories are not created in this sprint. This ADR
> establishes the policy before scaffolding.

### Generation Targets

| Source | Flutter (`packages/`) | Django (`services/`) |
| --- | --- | --- |
| OpenAPI spec | API client, DTOs | Serializers, route stubs |
| Shared models | Dart entities, JSON serialization | Pydantic/dataclass models |
| Config schema | Typed config classes | Settings validators |

### Rules

1. **Never hand-edit generated files** — changes flow upstream to definitions.
2. Generated files carry a header: `# GENERATED — DO NOT EDIT` (or Dart
  equivalent).
3. Generation runs in CI — drift between definitions and output fails the build.
4. Generators live in `scripts/generators/` (introduced in a future sprint).
5. `make generate` target will orchestrate all generators locally.

### Tooling Candidates (not installed in this sprint)

| Domain | Tool Options |
| -------- | ------------------------------------- |
| OpenAPI | `openapi-generator`, `ferry`, `drf-spectacular` (reverse) |
| Dart | `build_runner`, `freezed`, `json_serializable` |
| Python | `datamodel-code-generator`, `pydantic` |

## Alternatives

| Alternative | Why Not Chosen |
| --- | --- |
| Hand-written contracts | Drift between Flutter and Django over time |
| Shared runtime library only | Does not solve cross-language type safety |
| Protobuf/gRPC as primary IDL | Heavier curve; REST/OpenAPI fits current phase |
| Generate on publish (not in CI) | Drift undetected until runtime failures |
| No generation policy yet | Defers a costly retrofit when services multiply |

## Consequences

### Positive

- Single source of truth eliminates cross-stack contract drift.
- CI-enforced regeneration catches stale artifacts at PR time.
- Onboarding accelerates — contributors edit schemas, not boilerplate.
- Aligns with knowledge graph documentation ([ADR
  0005](0005-knowledge-graph.md)).

### Negative

- Upfront investment in generator scripts and CI integration.
- Generated code in PRs increases diff noise (mitigated by dedicated
  `generated/` paths).
- Generator version pinning required to avoid non-deterministic output.

### Neutral

- Decision on whether generated files are committed vs. CI-only is deferred to
  the scaffold sprint.
- Existing hand-written code (when introduced) must be migrated to generated
  equivalents incrementally.

## Future Review

Revisit when:

- First OpenAPI spec is published and first generator pipeline runs in CI.
- Generator output causes >30% of PR diff volume (consider commit policy
  change).
- A second IDL (Protobuf, GraphQL schema) is proposed.
- Generator maintenance burden exceeds one dedicated sprint per quarter.

**Next review date:** Upon introduction of `definitions/` and
`scripts/generators/` (Sprint 003+).

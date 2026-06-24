# 0005. Knowledge Graph

## Status

**Accepted** — 2026-06-24

## Context

AIONE is a multi-stack monorepo (Flutter, Django, infrastructure, ADRs, standards) that will grow in complexity. Contributors, reviewers, and AI-assisted tooling need a structured way to navigate relationships between components — which service owns which domain, which package is consumed by which app, and which ADR governs which decision.

Traditional flat documentation (README files, scattered wikis) does not capture **relationships** between artifacts. A knowledge graph model provides a machine-readable and human-readable map of the platform.

## Decision

Establish a **knowledge graph** as a first-class documentation artifact under `docs/` that models entities and their relationships across the monorepo.

### Entity Types

| Entity        | Example ID                  | Description                        |
| ------------- | --------------------------- | ---------------------------------- |
| `adr`         | `adr:0001`                  | Architecture Decision Record       |
| `service`     | `service:auth`              | Django backend service             |
| `app`         | `app:mobile`                | Flutter client application         |
| `package`     | `package:shared-models`     | Shared library                     |
| `standard`    | `standard:branch-strategy`  | Engineering standard document      |
| `workflow`    | `workflow:ci`               | CI/CD pipeline                     |
| `definition`  | `definition:openapi:auth`   | Generator source definition        |

### Relationship Types

| Relationship    | Example                                      |
| --------------- | -------------------------------------------- |
| `depends_on`    | `app:mobile` → `package:shared-models`       |
| `implements`    | `service:auth` → `adr:0003`                  |
| `generates`     | `definition:openapi:auth` → `package:api-client` |
| `governed_by`   | `service:auth` → `standard:commit-convention` |
| `supersedes`    | `adr:0005` → `adr:0001` (when applicable)    |
| `owned_by`      | `service:auth` → `team:platform`             |

### Representation (phased)

**Phase 1 (this sprint):** ADRs and standards cross-reference each other via Markdown links (already in place). The graph is implicit in documentation.

**Phase 2 (future sprint):** Introduce `docs/knowledge-graph/graph.yaml` — a YAML file listing entities and edges, validated in CI.

**Phase 3 (future sprint):** Auto-generate graph edges from code analysis (import graphs, `pubspec.yaml` dependencies, `requirements.txt`) and merge with manual overrides.

### Consumption

| Consumer            | Use Case                                    |
| ------------------- | ------------------------------------------- |
| Contributors        | Navigate impact of changes before opening PR |
| Code reviewers      | Verify ADR coverage for affected entities    |
| CI (`docs.yml`)     | Validate graph consistency and orphan nodes  |
| AI tooling          | Context retrieval for assisted development |

### Rules

1. Every new `service/`, `app/`, or `package/` must register in the knowledge graph (Phase 2+).
2. ADRs reference affected entities by ID where applicable.
3. Orphan entities (no inbound `governed_by` or `depends_on`) fail CI validation (Phase 2+).
4. The graph does not replace ADRs — it indexes them.

## Alternatives

| Alternative                  | Why Not Chosen                                    |
| ---------------------------- | ------------------------------------------------- |
| Wiki-only documentation      | No machine-readable relationships; drifts quickly |
| Code comments only           | Not discoverable across repository boundaries     |
| Full graph database (Neo4j)  | Over-engineered for current scale                   |
| No structured navigation     | Review quality degrades as monorepo grows         |
| Single ARCHITECTURE.md       | Does not scale; becomes stale immediately         |

## Consequences

### Positive

- Impact analysis becomes systematic — "what does this PR touch?"
- AI-assisted development gains structured context beyond raw file trees.
- Onboarding improves via explorable entity relationships.
- Complements generator-driven development ([ADR 0004](0004-generator-driven-development.md)) with traceability.

### Negative

- Manual graph maintenance adds overhead until Phase 3 automation.
- Risk of graph drift if registration is not enforced in CI.
- YAML schema design requires upfront agreement on entity/edge taxonomy.

### Neutral

- Phase 1 requires no new files — existing ADR cross-links satisfy the minimum.
- Visualization tooling (Mermaid, D2, or web UI) deferred to a future sprint.

## Future Review

Revisit when:

- `graph.yaml` is introduced and first CI validation runs (Phase 2).
- Entity count exceeds 50 or edge count exceeds 200.
- Auto-discovery (Phase 3) produces >20% conflicting edges vs. manual graph.
- A dedicated documentation portal is proposed.

**Next review date:** Upon introduction of `docs/knowledge-graph/graph.yaml` (Sprint 003+).

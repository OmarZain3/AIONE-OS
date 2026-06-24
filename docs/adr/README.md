# Architecture Decision Records (ADRs)

ADRs capture significant architectural and technical decisions along with their context and consequences.

## When to Write an ADR

Create an ADR when a decision:

- Affects multiple services, apps, or packages
- Is difficult or costly to reverse
- Introduces a new technology, pattern, or integration
- Has security, compliance, or operational impact

Skip ADRs for routine implementation choices already covered by existing standards.

## Format

Use the template below. File naming: `NNNN-short-title.md` (zero-padded sequence, kebab-case title).

```
docs/adr/
├── README.md
├── 0001-record-architecture-decisions.md
├── 0002-example-decision.md
└── ...
```

## Template

```markdown
# NNNN. Title

- **Status:** Proposed | Accepted | Deprecated | Superseded by [NNNN](NNNN-title.md)
- **Date:** YYYY-MM-DD
- **Deciders:** @team-or-individuals

## Context

What is the issue or driving force behind this decision?

## Decision

What is the change being proposed or enacted?

## Consequences

### Positive

- 

### Negative

- 

### Neutral

- 
```

## Lifecycle

1. **Proposed** — Open a PR with the ADR for discussion.
2. **Accepted** — Merged after review; implementation may proceed.
3. **Deprecated / Superseded** — Update status; link to the replacing ADR.

## Index

| ADR   | Title                              | Status   |
| ----- | ---------------------------------- | -------- |
| —     | No ADRs recorded yet               | —        |

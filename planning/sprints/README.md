# Sprints

Sprint index and operating model for AIONE delivery.

## Cadence

| Parameter | Value |
| --------- | ----- |
| Duration | 2 weeks |
| Planning | Day 1 — pull from [master_backlog.md](../master_backlog.md) |
| Review | Last day — update [execution_ledger.md](../execution_ledger.md) |
| Branch base | `develop` per branch strategy doc |

## Sprint Index

| Sprint | Window | Theme | Status | Exit criteria |
| ------ | ------ | ----- | ------ | ------------- |
| 001 | 2026-06 W1–2 | Foundation | **Complete** | v0.1.0-alpha; CI; Compose |
| 002 | 2026-06 W3–07 | App scaffold | **In progress** | Stack; E2E; v0.2 docs |
| 003 | 2026-07 W3 – 08 W2 | Generators | Planned | definitions/ + CI drift |
| 004 | 2026-08 W3 – 09 W2 | KG + packages | Planned | graph.yaml; package use |

## Sprint 002 — Current

**Goal:** Close Phase 1; ship `v0.2.0-beta`.

### Committed

| ID | Item | Owner |
| -- | ---- | ----- |
| BL-018 | Cross-stack E2E smoke test | — |
| BL-019 | README / CHANGELOG reconciliation | — |
| BL-020 | `founder_studio` README | — |
| TD-001 | Fix root README drift | — |
| TD-002 | Update CHANGELOG | — |

### Stretch

| ID | Item |
| -- | ---- |
| BL-021 | `CODEOWNERS` |
| BL-063 | Security contact |

### Definition of Done

- [ ] All committed items merged to `develop`
- [ ] `make ci` green
- [ ] `docker compose --profile app up` — backend + frontend healthy
- [ ] [release_plan.md](../release_plan.md) checklist ready for branch cut
- [ ] Risks R-001, R-002 updated in [risk_register.md](../risk_register.md)

## Sprint Folder Convention

Create `sprints/NNN-short-name/` only when a sprint needs artifacts beyond this
index (retros, notes). Default: track work via backlog IDs and execution ledger
— no per-sprint files required.

## References

- [Roadmap](../roadmap.md)
- [Master backlog](../master_backlog.md)
- [Release plan](../release_plan.md)
- [Decision log](../decision_log.md)
- ADRs: [0001](../../docs/adr/0001-repository-strategy.md) –
  [0005](../../docs/adr/0005-knowledge-graph.md)

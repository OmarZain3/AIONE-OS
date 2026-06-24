# Decision Log

Operational and planning decisions **below ADR threshold**. Architectural decisions belong in [`docs/adr/`](../docs/adr/README.md).

## Format

| ID | Date | Decision | Rationale | Status |
| -- | ---- | -------- | --------- | ------ |

---

## DL-001 · 2026-06-24 · Planning directory structure

**Decision:** Establish `planning/` at repo root for backlog, roadmap, ledger, risks, and sprint index — separate from `docs/` (ADRs, standards, runbooks).

**Rationale:** ADR 0001 reserves `docs/` for living documentation; planning artifacts change frequently and serve a different audience (delivery vs architecture).

**Status:** Active

---

## DL-002 · 2026-06-24 · Sprint numbering

**Decision:** Number sprints sequentially from foundation (`Sprint 001`). Sprint folders are created on demand; `sprints/README.md` is the canonical index.

**Rationale:** ADR 0004 references "Sprint 003+" for generators; consistent numbering enables cross-referencing.

**Status:** Active

---

## DL-003 · 2026-06-24 · Primary client app naming

**Decision:** First Flutter app is `founder_studio` (not `frontend`). Compose service remains `frontend` for port/env compatibility.

**Rationale:** Product identity over generic naming; minimizes Compose env churn. Entity ID: `app:founder_studio` per ADR 0005.

**Status:** Active — README and issue templates reference `apps/founder_studio`; Compose service name remains `frontend` (TD-012).

---

## DL-004 · 2026-06-24 · Single backend service (initial)

**Decision:** Consolidate all backend domains in `services/backend` as Django apps (`accounts`, `health`, `projects`, `core`) rather than splitting microservices.

**Rationale:** ADR 0003 defers service multiplication; monorepo alpha phase favors velocity and shared auth.

**Status:** Active — revisit when service count exceeds 5 (ADR 0003 Future Review).

---

## DL-005 · 2026-06-24 · Hand-written contracts (interim)

**Decision:** Auth and health API contracts are hand-written until Phase 2 generators land. No retrofit blocker for scaffold release.

**Rationale:** ADR 0004 explicitly defers `definitions/`; incremental migration (BL-034) follows generator introduction.

**Status:** Active — expires upon BL-030 completion.

---

## DL-006 · 2026-06-24 · Next release target

**Decision:** Target `v0.2.0-beta` for integrated scaffold (Phase 1 exit). Generators ship under `v0.3.0-alpha`.

**Rationale:** [versioning](../docs/standards/versioning.md): `beta` = feature-complete for wider testing; scaffold is not production-ready at `alpha`.

**Status:** Active

---

## When to Escalate to ADR

Per [ADR README](../docs/adr/README.md), escalate when a decision:

- Affects multiple top-level directories or release cadence
- Introduces a new framework, IDL, or architectural pattern
- Has irreversible infrastructure cost
- Changes public API contracts across stacks

Record escalation by opening `docs/adr/NNNN-title.md` with status **Proposed**.

# Technical Debt

Known debt items tracked for intentional repayment. Not a backlog substitute —
see [master_backlog.md](master_backlog.md) for planned work.

**Last updated:** 2026-06-24 (alpha freeze)

## Severity

| Level | Repayment window |
| ----- | ---------------- |
| Critical | Before next release |
| High | Current or next sprint |
| Medium | Within 2 sprints |
| Low | Backlog / opportunistic |

## Registry

| ID | Item | Severity | Location | ADR / Note | Target |
| -- | ---- | -------- | -------- | ---------- | ------ |
| TD-005 | Hand-written APIs | High | backend apps | ADR 0004 | Phase 2 |
| TD-006 | Empty packages | Medium | packages/ | ADR 0004 | Phase 3 |
| TD-007 | Empty scripts | Medium | scripts/ | ADR 0004 | Phase 2 |
| TD-008 | Empty infrastructure | Medium | infrastructure/ | ADR 0001 | Phase 4 |
| TD-009 | No E2E tests | High | tests/ | BL-018 | Sprint 002 |
| TD-010 | No CODEOWNERS | Medium | repo root | ADR 0001 | Sprint 003 |
| TD-011 | Alpha sec contact | Medium | SECURITY.md | BL-063 | Before beta |
| TD-012 | Compose frontend name | Low | compose.yml | DL-003 | Opportunistic |
| TD-013 | No logging/metrics | Medium | backend | ADR 0003 | Phase 4 |
| TD-014 | RBAC scope open | Low | accounts middleware | BL-071 | Phase 4 |
| TD-015 | KG Phase 2 pending | Medium | knowledge-graph/ | ADR 0005 | Phase 3 |
| TD-016 | HealthPage unrouted | Low | founder_studio lib | — | Sprint 002 |
| TD-017 | No registration API | Medium | accounts | — | Beta |
| TD-018 | Profile placeholder | Low | profile_page.dart | — | Beta |

## Debt Principles

1. **Document before accruing** — link ADR or decision log entry when accepting
  new debt.
2. **No silent debt** — PRs that introduce debt must add a row here or reference
  an existing ID.
3. **Repay with generators** — cross-stack duplication (TD-005, TD-006) is the
  highest ROI repayment.
4. **Docs are debt** — stale docs are Critical/High until the release they
  describe ships.

## Repayment History

| Date | ID | Action |
| ---- | -- | ------ |
| 2026-06-24 | TD-001 | Root README updated for alpha |
| 2026-06-24 | TD-002 | CHANGELOG 0.1.0-alpha expanded |
| 2026-06-24 | TD-003 | founder_studio README replaced with project guide |
| 2026-06-24 | TD-004 | `docs/adr/README.md` index lists ADRs 0001–0005 |
| 2026-06-24 | TD-011 | Security reporting via GitHub Advisories (alpha) |

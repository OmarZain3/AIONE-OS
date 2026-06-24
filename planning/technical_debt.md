# Technical Debt

Known debt items tracked for intentional repayment. Not a backlog substitute — see [master_backlog.md](master_backlog.md) for planned work.

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
| TD-005 | Hand-written API contracts (auth, health, projects) pre-generator | High | `services/backend/apps/`, `apps/founder_studio/lib/infrastructure/` | ADR 0004, DL-005 | Phase 2 |
| TD-006 | Empty `packages/` — duplicated client/server types | Medium | `packages/` | ADR 0004 | Phase 3 |
| TD-007 | Empty `scripts/` — no `make generate` | Medium | `scripts/` | ADR 0004 | Phase 2 |
| TD-008 | Empty `infrastructure/` — no deploy path | Medium | `infrastructure/` | ADR 0001 | Phase 4 |
| TD-009 | Empty `tests/` — no cross-cutting integration suite | High | `tests/` | BL-018 | Sprint 002 |
| TD-010 | No `CODEOWNERS` file | Medium | repo root | ADR 0001 | Sprint 003 |
| TD-011 | Alpha security contact (`security@aione.dev`) pending production alias | Medium | `SECURITY.md` | BL-063 | Before beta |
| TD-012 | Compose `frontend` service name vs `founder_studio` path | Low | `docker-compose.yml` | DL-003 | Opportunistic |
| TD-013 | No structured logging / metrics in backend | Medium | `services/backend/` | ADR 0003 | Phase 4 |
| TD-014 | Permission middleware present; RBAC scope undefined | Low | `apps/accounts/middleware/` | BL-071 | Phase 4 |
| TD-015 | Knowledge graph Phase 2 not started | Medium | `docs/knowledge-graph/` | ADR 0005 | Phase 3 |
| TD-016 | `HealthPage` implemented and tested but not routed in GoRouter | Low | `apps/founder_studio/lib/presentation/` | — | Sprint 002 |
| TD-017 | No public user registration endpoint (admin-only user creation) | Medium | `services/backend/apps/accounts/` | — | Beta |
| TD-018 | Profile screen is placeholder UI only | Low | `apps/founder_studio/lib/presentation/pages/profile_page.dart` | — | Beta |

## Debt Principles

1. **Document before accruing** — link ADR or decision log entry when accepting new debt.
2. **No silent debt** — PRs that introduce debt must add a row here or reference an existing ID.
3. **Repay with generators** — cross-stack duplication (TD-005, TD-006) is the highest ROI repayment.
4. **Docs are debt** — stale docs are Critical/High until the release they describe ships.

## Repayment History

| Date | ID | Action |
| ---- | -- | ------ |
| 2026-06-24 | TD-001 | Root README updated for alpha implementation and `apps/founder_studio` |
| 2026-06-24 | TD-002 | CHANGELOG `0.1.0-alpha` expanded with Founder Studio, auth, projects, runtime |
| 2026-06-24 | TD-003 | `founder_studio` README replaced with project-specific documentation |
| 2026-06-24 | TD-004 | `docs/adr/README.md` index lists ADRs 0001–0005 |
| 2026-06-24 | TD-011 | Security reporting updated to GitHub Advisories + `security@aione.dev` (alpha) |

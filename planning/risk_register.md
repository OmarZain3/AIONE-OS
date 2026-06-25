# Risk Register

Identified risks for AIONE delivery. Reviewed at sprint planning and before
releases.

**Last reviewed:** 2026-06-24

## Scoring

| Likelihood | Impact | Priority |
| ---------- | ------ | -------- |
| H / M / L | H / M / L | P0 (H+H, H+M, M+H) · P1 (M+M) · P2 (L or remaining) |

## Active Risks

| ID | Risk | L | I | Pri | Mitigation | Owner | Status |
| -- | ---- | - | - | --- | ---------- | ----- | ------ |
| R-001 | Contract drift | M | H | P0 | ADR 0004; OpenAPI | Plat | Open |
| R-002 | Doc drift | H | M | P0 | BL-019; PR checklist | Docs | Open |
| R-003 | CI growth | M | M | P1 | Path-aware CI (ADR 0001) | CI | Monitor |
| R-004 | Generator retrofit | M | H | P1 | ADR 0004; BL-030-035 | Plat | Open |
| R-005 | KG maintenance | M | M | P1 | ADR 0005 phased links | Docs | Monitor |
| R-006 | Local dev secrets | M | H | P1 | Rotation; secrets mgr | Sec | Open |
| R-007 | Placeholder contact | L | H | P1 | BL-063 before beta | Sec | Open |
| R-008 | Single backend | L | M | P2 | ADR 0003 at 5 services | BE | Accept |
| R-009 | Flutter SDK | M | L | P2 | CI test; skip w/o SDK | DevEx | Accept |
| R-010 | Empty infra | M | M | P1 | Phase 3 pkg; Phase 4 IaC | Infra | Open |
| R-011 | No E2E tests | M | M | P1 | BL-018 Sprint 002 | QA | Open |
| R-012 | ADR 0001 review | L | L | P2 | Track CI wall-clock | Lead | Monitor |

## Closed / Accepted

| ID | Risk | Resolution |
| -- | ---- | ---------- |
| — | Polyrepo coordination overhead | Accepted via ADR 0001 (monorepo) |
| — | Clean architecture boilerplate | Accepted via ADR 0002 |

## Review Cadence

- **Sprint planning:** Re-score open P0/P1 risks.
- **Release gate:** No open P0 without documented acceptance or mitigation.
- **Quarterly:** Full register review; archive mitigated items.

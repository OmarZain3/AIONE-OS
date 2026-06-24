# Risk Register

Identified risks for AIONE delivery. Reviewed at sprint planning and before releases.

**Last reviewed:** 2026-06-24

## Scoring

| Likelihood | Impact | Priority |
| ---------- | ------ | -------- |
| H / M / L | H / M / L | P0 (H+H, H+M, M+H) · P1 (M+M) · P2 (L or remaining) |

## Active Risks

| ID | Risk | L | I | Pri | Mitigation | Owner | Status |
| -- | ---- | - | - | --- | ---------- | ----- | ------ |
| R-001 | **Contract drift** between Flutter client and Django API as features grow | M | H | P0 | Phase 2 generators (ADR 0004); OpenAPI as interim source (`/api/schema/`) | Platform | Open |
| R-002 | **Documentation drift** — README/CHANGELOG lag implementation | H | M | P0 | BL-019; PR checklist requires doc updates | Docs | Open |
| R-003 | **Monorepo CI duration** grows with apps/services | M | M | P1 | Path-aware jobs (ADR 0001); matrix discovery already in place | CI | Monitor |
| R-004 | **Generator retrofit cost** if deferred past Phase 2 | M | H | P1 | ADR 0004 policy set; BL-030–035 scheduled in roadmap | Platform | Open |
| R-005 | **Knowledge graph maintenance** burden without automation | M | M | P1 | Phase 1 implicit links (ADR 0005); Phase 3 auto-discovery | Docs | Monitor |
| R-006 | **Secrets in local dev** — `.env` defaults (`change-me`) used in Compose | M | H | P1 | Document rotation; secrets manager for staging/prod (BL-061) | Security | Open |
| R-007 | **Placeholder security contact** delays vulnerability response | L | H | P1 | BL-063; replace before external beta | Security | Open |
| R-008 | **Single backend bottleneck** — all domains in one Django project | L | M | P2 | ADR 0003 review trigger at 5 services; modular app boundaries now | Backend | Accept |
| R-009 | **Flutter SDK dependency** blocks contributors without local SDK | M | L | P2 | CI runs analyze/test; pre-commit skips if SDK absent | DevEx | Accept |
| R-010 | **Empty `packages/` and `infrastructure/`** — no shared abstractions or deploy path | M | M | P1 | Phase 3 packages; Phase 4 staging IaC per roadmap | Infra | Open |
| R-011 | **No cross-cutting E2E tests** — regressions caught late | M | M | P1 | BL-018 in Sprint 002 closeout | QA | Open |
| R-012 | **ADR 0001 review** (2026-12-24) may conflict with trunk-based pressure | L | L | P2 | Track contributor count and CI wall-clock | Eng Lead | Monitor |

## Closed / Accepted

| ID | Risk | Resolution |
| -- | ---- | ---------- |
| — | Polyrepo coordination overhead | Accepted via ADR 0001 (monorepo) |
| — | Clean architecture boilerplate | Accepted via ADR 0002 |

## Review Cadence

- **Sprint planning:** Re-score open P0/P1 risks.
- **Release gate:** No open P0 without documented acceptance or mitigation.
- **Quarterly:** Full register review; archive mitigated items.

# Phase 0 Execution Backlog

Last updated: 2026-04-09

## Objective
Close all remaining Phase 0 exit criteria in a controlled order.

## Workstream A - ERD Finalization
1. Review [ERD_SIGNOFF.md](ERD_SIGNOFF.md) with backend and product.
2. Resolve open decision on composer modeling. [done]
3. Lock final schema version and migration policy.

Done when:
- Review checklist fully checked.
- Technical + product owner signatures added.
- Composer modeling decision recorded in ERD sign-off.

## Workstream B - Data Seeding to 50k
1. Define initial target media list and ingestion batches. [in progress]
2. Implement pipeline jobs for Spotify + Apple + MusicBrainz aliases.
3. Run staged ingestion and duplicate cleanup.
4. Produce seeded record count report.

Done when:
- Track count >= 50,000.
- Alias coverage report accepted.
- Initial seed target plan documented in [MEDIA_SEED_TARGETS.md](MEDIA_SEED_TARGETS.md).

## Workstream C - Typesense Validation
1. Provision Typesense in staging. [pending staging]
2. Load seed subset and alias documents. [pending ingestion]
3. Execute test plan in [TYPESENSE_VALIDATION_PLAN.md](TYPESENSE_VALIDATION_PLAN.md). [in progress]
4. Record latency metrics and failures.

Done when:
- Functional tests pass.
- p95 latency < 80ms.
- Smoke matrix documented in [TYPESENSE_SMOKE_TESTS.md](TYPESENSE_SMOKE_TESTS.md).

## Workstream D - Staging Infrastructure
1. Follow [STAGING_INFRA_CHECKLIST.md](STAGING_INFRA_CHECKLIST.md). [in progress]
2. Configure CI/CD for staging deploys.
3. Run smoke test suite against staging.

Done when:
- Infra checklist completed and signed.
- Environment plan documented in [STAGING_ENVIRONMENT_PLAN.md](STAGING_ENVIRONMENT_PLAN.md).

## Workstream E - Legal Finalization
1. Legal review of [PRIVACY_POLICY_DRAFT.md](../legal/PRIVACY_POLICY_DRAFT.md). [in progress]
2. Legal review of [TERMS_OF_SERVICE_DRAFT.md](../legal/TERMS_OF_SERVICE_DRAFT.md).
3. Apply counsel edits and finalize publication version.

Done when:
- Final legal docs approved.
- Publication-ready markdown files produced.
- Review flow documented in [../legal/LEGAL_REVIEW_PLAN.md](../legal/LEGAL_REVIEW_PLAN.md).

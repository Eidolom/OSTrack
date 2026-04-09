# Phase 0 Staging Environment Plan

Last updated: 2026-04-09
Status: Draft

## Purpose
Turn the staging checklist into a concrete implementation order for infra provisioning, CI/CD, and smoke validation.

## Environment Layout

### 1. App Hosting
Recommended: Render or Railway

Responsibilities:
- Host backend/API service(s)
- Expose health endpoint
- Provide staging domain for app integration testing

Setup notes:
- One staging app per service
- Separate environment variables from production
- Store secrets in platform secret manager only

### 2. Postgres
Recommended: Supabase

Responsibilities:
- Staging relational database
- Seed/import test dataset
- Support schema validation and migrations

Setup notes:
- Use separate staging project
- Create a limited-privilege service user for app access
- Back up before each migration rehearsal

### 3. Object Storage
Recommended: Cloudflare R2

Responsibilities:
- Artwork and asset storage for staging
- Support upload and retrieval paths used by app

Setup notes:
- Keep staging bucket isolated from production
- Use signed URLs or scoped access where possible

### 4. Search
Recommended: Typesense Cloud

Responsibilities:
- Multilingual alias search
- Staging ranking validation
- Latency measurement and regression testing

Setup notes:
- One staging collection per primary content type if needed
- Document schema and indexing rules next to the smoke tests

### 5. Push Notifications
Recommended: Firebase Cloud Messaging

Responsibilities:
- Device push plumbing for later beta validation

Setup notes:
- Staging-only Firebase project
- Separate Android and iOS credentials from production

### 6. Error Monitoring
Recommended: Sentry

Responsibilities:
- Capture runtime errors from app and backend
- Route alerts to team channel

Setup notes:
- Use staging environment tag
- Confirm source maps or Flutter symbol support where applicable

### 7. Analytics
Recommended: PostHog

Responsibilities:
- Record high-level usage for staging validation
- Verify event schema before product beta

Setup notes:
- Staging project distinct from production
- Restrict personally identifiable data in staging events

## CI/CD Plan

### GitHub Actions
Jobs:
- lint
- test
- build Android debug artifact
- build iOS staging artifact if runner access is available

### Deployment Targets
- Push to staging branch triggers staging deploy
- Tagged release candidate triggers internal distribution workflow

### Distribution Channels
- Android: internal testing track or direct APK install
- iOS: TestFlight internal group

## Secrets and Access
- Store all secrets in platform secret managers or GitHub secrets.
- Maintain a separate staging access group.
- Document who can rotate keys and revoke access.

## Smoke Test Sequence
1. Start from a clean device or emulator.
2. Verify app boots and onboarding path appears if no preferences exist.
3. Verify Auth0 login completes.
4. Verify return to home shell and persisted login/session state.
5. Verify search calls hit staging Typesense and return seeded results.
6. Verify health endpoint responds.
7. Verify error monitoring receives a test event.

## Acceptance Criteria
- Staging app accessible.
- Database reachable and seeded.
- Search index reachable with smoke tests passing.
- Monitoring and analytics are live.
- CI/CD can deploy a staging build without manual file edits.

## Open Questions
- Choose final host between Render and Railway.
- Decide whether staging API and app share a domain or separate subdomains.
- Confirm whether iOS staging distribution needs a dedicated bundle identifier.

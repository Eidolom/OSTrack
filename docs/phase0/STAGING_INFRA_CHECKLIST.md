# Phase 0 Staging Infrastructure Checklist

Status: Draft
Last updated: 2026-04-09

Related plan: [STAGING_ENVIRONMENT_PLAN.md](STAGING_ENVIRONMENT_PLAN.md)

## Goal
Provision a staging environment that mirrors production decisions from Phase 0 roadmap.

## Core Services
- [ ] App hosting provisioned (Railway or Render)
- [ ] Postgres provisioned (Supabase)
- [ ] Object storage provisioned (Cloudflare R2)
- [ ] Search provisioned (Typesense Cloud)
- [ ] Push setup provisioned (Firebase Cloud Messaging)
- [ ] Error monitoring configured (Sentry)
- [ ] Analytics configured (PostHog)

## Environment Management
- [ ] Secrets stored in environment manager (no plaintext in repo)
- [ ] Staging env vars documented
- [ ] Key rotation owner assigned

## CI/CD
- [ ] GitHub Actions pipeline runs lint + tests
- [ ] Android internal distribution configured
- [ ] iOS TestFlight pipeline configured
- [ ] Rollback instructions documented

## Reliability Baseline
- [ ] Health endpoint for core backend services
- [ ] Error alerts routed to team channel
- [ ] Basic dashboards for API latency and failures

## Security Baseline
- [ ] Principle of least privilege applied to service credentials
- [ ] TLS enabled for all externally reachable services
- [ ] Access audit for staging admin roles completed

## Acceptance
- [ ] Full smoke test passes in staging
- [ ] Infra owner signs off
- [ ] Product owner signs off

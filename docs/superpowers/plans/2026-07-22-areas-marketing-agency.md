# Areas and Marketing Agency Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a scalable architecture for composable business/technical areas and an autonomous marketing agency operating model usable by OpenHands.

**Architecture:** Add `factory/areas/` as the capability composition layer, with YAML contracts per area. Add `factory/agency/` as the autonomous marketing agency operating model, with gates, services, approval policy, and client composition template. Extend validation and Codegraph reporting so area contracts are checked and mapped.

**Tech Stack:** Markdown, YAML, Bash scripts, existing `factory/` docs and generated Codegraph reports.

---

### Task 1: Add area contracts

**Files:**
- Create: `factory/areas/README.md`
- Create: `factory/areas/area-schema.md`
- Create: `factory/areas/*/area.yaml`
- Create: `factory/areas/*/README.md`

- [ ] Create composable area contracts for marketing, product, design, architecture, data, development, qa, uat, devops, and security.

### Task 2: Add autonomous marketing agency model

**Files:**
- Create: `factory/agency/README.md`
- Create: `factory/agency/autonomous-marketing/README.md`
- Create: `factory/agency/autonomous-marketing/services.md`
- Create: `factory/agency/autonomous-marketing/agents.md`
- Create: `factory/agency/autonomous-marketing/approval-policy.md`
- Create: `factory/agency/autonomous-marketing/quality-gates.md`
- Create: `factory/agency/autonomous-marketing/client-composition-template.yaml`
- Create: `factory/agency/autonomous-marketing/openhands.md`

- [ ] Define safe autonomous workflows, required human approvals, and OpenHands operating rules.

### Task 3: Extend validation and Codegraph

**Files:**
- Modify: `scripts/check-factory-docs.sh`
- Modify: `scripts/generate-codegraph-report.sh`
- Modify: `factory/INDEX.md`
- Modify: `factory/README.md`

- [ ] Validate area files, agency files, and generate `area-map.md`.

### Task 4: Run checks

**Commands:**
- `./scripts/generate-codegraph-report.sh`
- `./scripts/check-factory-docs.sh`

- [ ] Confirm both commands pass.

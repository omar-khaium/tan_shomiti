# Delivery Plan (Sprints + Modular Tasks)

This document breaks the Tan Shomiti app into **task-sized vertical slices** that can be executed by agents in a repeatable pipeline:

1) **Figma MCP agent**: design UI + interaction specs  
2) **Codex agent**: implement Flutter UI from Figma (1:1)  
3) **Codex agent**: integrate backend/data + domain/business logic  
4) **Codex agent**: unit tests  
5) **Codex agent**: Patrol UI tests  
6) **Codex agent**: E2E tests (end-to-end flows)

All tasks are designed to remain **100% compliant with `rules.md`**, and should reference `architecture.md` for layering boundaries.

---

## 0) Workflow Standard (Per Task)

### 0.1 Branching

- **One task = one branch**.
- Branch naming (required prefix): `codex/TS-<id>-<slug>`
  - Example: `codex/TS-201-members-crud`

### 0.2 Commits (one commit per stage, minimum)

Commit message pattern:
- `TS-<id> (stage1): figma spec`
- `TS-<id> (stage2): flutter ui`
- `TS-<id> (stage3): domain+data integration`
- `TS-<id> (stage4): unit tests`
- `TS-<id> (stage5): patrol tests`
- `TS-<id> (stage6): e2e tests`

Rules:
- Every commit must keep `main` buildable (no “broken in-between” commits).
- Each stage commit includes its **stage-specific checks** (see below).

### 0.3 Stage Deliverables + Checks

**Stage 1 — Figma (design)**
- Deliverables:
  - Figma links (file + page + node URLs) and interaction notes
  - states: loading/empty/error/success
  - accessibility notes (tap targets, contrast)
  - copy text (no shaming language; privacy-sensitive wording)
- Repo output (commit):
  - Add/update a short task spec at `docs/tasks/TS-<id>.md` (includes Figma URLs + acceptance criteria)
- Checks (record in PR / CI optional):
  - `flutter analyze`
  - `flutter test`

**Stage 2 — Flutter UI (from Figma)**
- Deliverables:
  - UI matches Figma and uses reusable components (no business logic in widgets)
  - navigation wired to existing router, but uses fake/demo data only
- Checks:
  - `flutter analyze`
  - `flutter test` (widget tests for at least: empty/loading/error states)

**Stage 3 — Domain + Data integration**
- Deliverables:
  - domain entities/value objects + use-cases added/updated
  - repository interfaces in domain, implementations in data layer
  - controllers wired (Riverpod) + persistence (local first)
  - audit + ledger events written where relevant
- Checks:
  - `flutter analyze`
  - `flutter test`

**Stage 4 — Unit tests**
- Deliverables:
  - use-case tests that enforce `rules.md` invariants for this feature
  - repository tests (if data rules exist)
- Checks:
  - `flutter test`
  - (optional) `flutter test --coverage`

**Stage 5 — Patrol UI tests**
- Deliverables:
  - Patrol tests for primary UI flows in this task (screens + key interactions)
- Checks:
  - `patrol test` (or your project’s configured Patrol command)

**Stage 6 — E2E tests**
- Deliverables:
  - Extend end-to-end suite to include the full slice behavior
  - Ensure cross-feature happy-path still works
- Checks:
  - `patrol test` E2E suite (smoke + full)

### 0.4 GitHub PR + Merge Policy (GitHub agent / gh CLI)

Create a PR early (draft) so checks and review are continuous.

Suggested `gh` flow:
- Create issue (optional but recommended): `gh issue create`
- Branch + push: `git checkout -b codex/TS-<id>-<slug>` then `git push -u origin HEAD`
- Draft PR: `gh pr create --draft --base main --fill`
- Checks: `gh pr checks`
- After Stage 6 passes: mark ready + merge:
  - `gh pr ready`
  - `gh pr merge --rebase --delete-branch`

Policy:
- **Do not merge to `main`** until **Stage 6 E2E is green**.
- Merge should keep the stage commits (prefer **rebase merge** over squash).

---

## 1) Sprint Cadence

- Sprint length: **2 weeks** (adjustable)
- Sprint goal: deliver **reviewable, shippable increments** (each task merges only after E2E)
- WIP rule: keep at most **2 tasks in progress** concurrently (to reduce integration risk)

---

## 2) Sprint Plan (Backlog → Increments)

### Sprint 0 — Foundations (must land first)

**Goal:** establish the scaffolding so every later task is fast, consistent, and testable.

- **TS-001 App Shell + Navigation**
  - Outcome: app bootstrap, router, base layout (dashboard shell), basic error/loading pages
- **TS-002 Design System (Tokens + Components)**
  - Outcome: theme, typography, spacing, reusable widgets (buttons, inputs, cards, table rows, badges)
- **TS-003 Data & Audit Foundation**
  - Outcome: local persistence baseline (DB choice), repositories skeleton, audit event logger, append-only ledger primitives
- **TS-004 Test Harness Setup**
  - Outcome: unit/widget testing conventions, Patrol configured, E2E “smoke” flow runs on a reference device/emulator

### Sprint 1 — Setup + Governance

**Goal:** create a Shomiti and lock in the rule snapshot (`RuleSetVersion`) + consent.

- **TS-101 Shomiti Setup Wizard (Rules Snapshot)**
  - Captures: Section 1 setup fields, policies selections, cycle length, deadlines, payout method
- **TS-102 Member Sign-Off + Roles**
  - Captures: Section 4 roles (Coordinator/Treasurer/Auditor) + Section 18 sign-off proofs
- **TS-103 Rules Viewer (Current Rules)**
  - Outcome: read-only view of active rules + version id (supports “zero surprises”)

### Sprint 2 — Members + Shares + Risk Controls

**Goal:** manage members/shares and reduce default risk before money flow starts.

- **TS-201 Members CRUD (Identity + Contact + Emergency)**
  - Covers: Section 3 identity/eligibility and privacy constraints
- **TS-202 Shares Management (Single/Multiple Shares)**
  - Covers: Section 5 and Section 10 (cap, per-share eligibility)
- **TS-203 Guarantor / Security Deposit**
  - Covers: Section 9.3 (risk controls) + proof capture
- **TS-204 Exit, Replacement, Removal (Governance ops)**
  - Covers: Section 14 (exit/replacement/removal rules)

### Sprint 3 — Contributions & Collection

**Goal:** monthly collection workflow becomes reliable and auditable.

- **TS-301 Monthly Dues Generation + Calendar**
  - Covers: due amounts per member/share, BillingMonth handling
- **TS-302 Record Payments + Receipts**
  - Covers: Section 6 receipts + proof attachments
- **TS-303 Late Fees + Eligibility Gate**
  - Covers: Section 9.1 late fee/grace + “not eligible to win if unpaid”
- **TS-304 Short Pot Handling Policies**
  - Covers: Section 9.2 (A postpone / B reserve / C guarantor) as configurable policy
- **TS-305 Default Management + Enforcement Steps**
  - Covers: Section 9.3 (default definition + enforcement steps)

### Sprint 4 — Draw + Payout

**Goal:** draw + payout are fair, witnessed, and follow “no partial pot payout”.

- **TS-401 Eligibility Computation + Draw Recording**
  - Covers: Section 7 eligibility and one-win-per-share-per-cycle
- **TS-402 Witness Sign-Off + Redo Flow**
  - Covers: Section 7 witnesses + redo integrity handling
- **TS-403 Payout Approval Flow + Proof**
  - Covers: Section 8 + Section 4 two-person verification

### Sprint 5 — Ledger, Statements, Amendments, Disputes

**Goal:** transparency, governance, and conflict handling are fully supported.

- **TS-501 Ledger View + Monthly Statement Generation**
  - Covers: Section 12 ledger + statement within 24h (operational checklist)
- **TS-502 Statement Sign-Off (Auditor/Witness)**
  - Covers: Section 12 audit sign-off + Section 17 checklist completion
- **TS-503 Rule Amendments + Unanimous Consent**
  - Covers: Section 15 rule change constraints + written record
- **TS-504 Disputes Workflow**
  - Covers: Section 13 (steps, evidence, resolution)

### Sprint 6 — Privacy, Exports, Release Hardening

**Goal:** safe sharing, privacy defaults, and release readiness.

- **TS-601 Exports (PDF/CSV) + Redaction + Consent Gates**
  - Covers: Section 16 privacy and “do not share without consent”
- **TS-602 Operational Monthly Checklist Dashboard**
  - Covers: Section 17 as an interactive guided checklist
- **TS-603 Performance/Accessibility/Localization Pass**
  - Outcome: a11y labels, keyboard nav where relevant, i18n-ready copy, performance fixes

---

## 3) Task Cards (Detailed Stage Checklists)

Use this template for each task in `docs/tasks/TS-<id>.md`.

### Template

**Goal:**  
**Rules coverage (rules.md section numbers):**  
**Depends on:**  
**Out of scope:**  

**Stage 1 (Figma)**
- [ ] Frames: main + loading + empty + error + success
- [ ] Components used: (list)
- [ ] Figma URLs:
  - File:
  - Nodes:
- [ ] Copy & privacy notes:
- [ ] Commit: `TS-<id> (stage1): figma spec`

**Stage 2 (Flutter UI)**
- [ ] Flutter pages/widgets implemented from Figma
- [ ] Accessibility basics (labels, tap targets)
- [ ] Checks: `flutter analyze`, `flutter test`
- [ ] Commit: `TS-<id> (stage2): flutter ui`

**Stage 3 (Logic integration)**
- [ ] Domain entities/value objects + use cases
- [ ] Repositories + data sources
- [ ] Controller wiring (Riverpod)
- [ ] Audit/ledger events where required
- [ ] Checks: `flutter analyze`, `flutter test`
- [ ] Commit: `TS-<id> (stage3): domain+data integration`

**Stage 4 (Unit tests)**
- [ ] Use-case tests for rules invariants
- [ ] Repository tests if needed
- [ ] Checks: `flutter test`
- [ ] Commit: `TS-<id> (stage4): unit tests`

**Stage 5 (Patrol UI tests)**
- [ ] Patrol tests cover main interactions
- [ ] Checks: `patrol test`
- [ ] Commit: `TS-<id> (stage5): patrol tests`

**Stage 6 (E2E tests)**
- [ ] E2E scenario added/updated (happy path + key failure)
- [ ] Checks: `patrol test` (E2E suite)
- [ ] Commit: `TS-<id> (stage6): e2e tests`

**Definition of Done**
- [ ] All stages complete and committed
- [ ] PR checks green
- [ ] E2E green
- [ ] Merge to `main` (rebase merge) + delete branch

# Tasks (Master Project Plan)

This is the **single source of truth** for the project backlog and execution order, derived from:
- `rules.md` (business rules + compliance)
- `architecture.md` (Clean Architecture boundaries + domain model)
- `sprints.md` (sprint cadence + 6-stage delivery pipeline + Git strategy)

> Important: Every task below must follow the **6-stage pipeline** and **one-branch-per-task** rules described in `sprints.md`.

---

## A) Global Execution Rules (applies to every task)

### A1) Branch + PR
- Branch: `codex/TS-<id>-<slug>`
- Create a **draft PR** at Stage 1 and keep it updated until merge.
- Merge to `main` **only after Stage 6 (E2E) passes**.
- Prefer **rebase merge** to keep stage commits.

### A2) Stage commits (minimum)
Each task produces (at least) these commits:
1) `TS-<id> (stage1): figma spec`
2) `TS-<id> (stage2): flutter ui`
3) `TS-<id> (stage3): domain+data integration`
4) `TS-<id> (stage4): unit tests`
5) `TS-<id> (stage5): patrol tests`
6) `TS-<id> (stage6): e2e tests`

### A3) “Figma stage” for non-UI tasks
Some tasks are backend-heavy (DB, CI). To keep the pipeline consistent:
- Stage 1 still uses **Figma MCP**, but may output:
  - a lightweight **FigJam diagram** (architecture/flow), and/or
  - a minimal “developer/admin” UI frame if a screen is required later.

### A4) Definition of Done (task-level)
- All 6 stages complete and committed on the task branch
- PR checks green
- E2E green
- Merged to `main` (rebase merge) and branch deleted

---

## B) Task Index (MVP)

IDs follow the sprint grouping from `sprints.md`. “Rules” refers to `rules.md` section numbers.

### Sprint 0 — Foundations
- **TS-001** App Shell + Navigation — Rules: supports all (foundation)
- **TS-002** Design System (Tokens + Components) — Rules: supports all (copy/UX/privacy)
- **TS-003** Data & Audit Foundation — Rules: 2, 4, 12, 16, 17
- **TS-004** Test Harness Setup (Unit/Widget/Patrol/E2E + CI) — Rules: supports all

### Sprint 1 — Setup + Governance
- **TS-101** Shomiti Setup Wizard (RuleSetVersion snapshot) — Rules: 1, 5, 6, 9.2, 10, 11, 15
- **TS-102** Member Sign-Off + Roles — Rules: 4, 18
- **TS-103** Rules Viewer (Current Rules + version) — Rules: 2, 12, 15

### Sprint 2 — Members + Shares + Risk Controls
- **TS-201** Members CRUD (Identity + Contact + Emergency) — Rules: 3, 16
- **TS-202** Shares Management (Single/Multiple Shares) — Rules: 5, 10
- **TS-203** Guarantor / Security Deposit — Rules: 9.3
- **TS-204** Exit, Replacement, Removal (Governance ops) — Rules: 14

### Sprint 3 — Contributions & Collection
- **TS-301** Monthly Dues Generation + Calendar — Rules: 6, 17
- **TS-302** Record Payments + Receipts — Rules: 6, 12
- **TS-303** Late Fees + Eligibility Gate — Rules: 7.2, 9.1
- **TS-304** Short Pot Handling Policies — Rules: 6.5, 9.2
- **TS-305** Default Management + Enforcement Steps — Rules: 9.3

### Sprint 4 — Draw + Payout
- **TS-401** Eligibility Computation + Draw Recording — Rules: 7
- **TS-402** Witness Sign-Off + Redo Flow — Rules: 7
- **TS-403** Payout Approval Flow + Proof — Rules: 4, 5.4, 8

### Sprint 5 — Ledger, Statements, Amendments, Disputes
- **TS-501** Ledger View + Monthly Statement Generation — Rules: 12, 17
- **TS-502** Statement Sign-Off (Auditor/Witness) — Rules: 4, 12, 17
- **TS-503** Rule Amendments + Unanimous Consent — Rules: 15
- **TS-504** Disputes Workflow — Rules: 13

### Sprint 6 — Privacy, Exports, Release Hardening
- **TS-601** Exports (PDF/CSV) + Redaction + Consent Gates — Rules: 12, 16
- **TS-602** Operational Monthly Checklist Dashboard — Rules: 17
- **TS-603** Performance/Accessibility/Localization Pass — Rules: 16

---

## C) Detailed Task Cards (MVP)

Use the checklist template in `sprints.md` when executing. Each task below adds **scope-specific** acceptance criteria and test focus.

### TS-001 — App Shell + Navigation
**Goal:** Establish app bootstrap, routing, and a stable shell for all features.  
**Depends on:** none.  
**Key UI:** splash/loading, error page, dashboard shell, left-to-right navigation patterns.  
**Key architecture:** `lib/src/app/app.dart`, `router.dart`, dependency bootstrap hooks.

**Stage 2 acceptance (Flutter UI):**
- App shell layout that can host feature modules (Dashboard + tabs/sections).
- Global empty/loading/error UI patterns (reusable).

**Stage 3 acceptance (Logic integration):**
- Riverpod `ProviderScope` in root and bootstrap wiring (no feature logic yet).
- Route guards for “Shomiti not created yet” vs “existing Shomiti”.

**Tests:**
- Unit/widget: app starts, router resolves known routes, error screen renders.
- Patrol: smoke opens app and navigates between top-level sections.
- E2E: “launch → dashboard shell visible”.

---

### TS-002 — Design System (Tokens + Components)
**Goal:** Create a reusable UI foundation aligned to Figma and accessible by default.  
**Depends on:** TS-001.  
**Key UI:** theme, typography, spacing, components library.

**Stage 2 acceptance (Flutter UI):**
- Centralized theme tokens (colors, typography, radius, spacing).
- Components: primary/secondary button, text field, dropdown, card, list row, badge/status chip, empty state, loading state.

**Stage 3 acceptance (Logic integration):**
- No domain logic; only component APIs and examples/story pages.

**Tests:**
- Widget tests for components (states + semantics labels).
- Patrol: open “components gallery” screen.
- E2E: include in smoke flow for fast validation.

---

### TS-003 — Data & Audit Foundation
**Goal:** Local-first persistence + audit trail primitives (append-only ledger foundations).  
**Depends on:** TS-001 (app shell).  
**Rules coverage:** 2, 4 (two-person oversight support), 12 (records), 16 (privacy), 17 (operational).

**Stage 1 (Figma/FigJam):**
- FigJam data-flow diagram: UI → controllers → use-cases → repositories → DB.
- Minimal “Audit Log Viewer” frame (optional).

**Stage 3 acceptance (Logic integration):**
- Choose and integrate a local DB (recommended: SQLite with Drift for strong typing + relational queries).
- Implement core tables + repositories scaffolding:
  - audit events
  - ledger entries (append-only)
  - rule set versions (placeholder)
- Provide a migration strategy and a repository testing pattern.

**Tests:**
- Unit: append-only invariants for ledger entries.
- Data tests: migrations + basic CRUD for audit/ledger.
- E2E: smoke still passes with DB initialized.

---

### TS-004 — Test Harness Setup (Unit/Widget/Patrol/E2E + CI)
**Goal:** CI-ready testing + automation patterns so every later task is fast and consistent.  
**Depends on:** TS-001..TS-003 (light dependency).  
**Stage 1 (Figma/FigJam):** optional (test strategy diagram).

**Stage 3 acceptance (Logic integration):**
- Standard test utilities:
  - fake clock/time helpers for BillingMonth
  - repository fakes/mocks pattern
  - Riverpod provider overrides pattern
- Add a CI workflow (GitHub Actions) to run:
  - `flutter analyze`
  - `flutter test`
  - (Patrol optional in CI initially; at least document how to run)

**Tests:**
- Ensure a baseline unit test and Patrol smoke test run in local dev.

---

### TS-101 — Shomiti Setup Wizard (RuleSetVersion snapshot)
**Goal:** Create Shomiti + capture a complete `RuleSetVersion` snapshot from `rules.md` Section 1 (and policy choices).  
**Depends on:** TS-001..TS-003.  
**Rules coverage:** 1, 5, 6, 9.2, 10, 11, 15.

**Key UI:**
- Setup Wizard steps:
  1) Shomiti name + start date
  2) Group type (closed/open) + member count N + share value S
  3) Shares policy (max shares, transfer allowed?)
  4) Meeting schedule + payment deadline
  5) Missed payment policy (A/B/C) + late policy inputs
  6) Optional fees policy (Section 11)
  7) Review + confirm (creates immutable RuleSetVersion)

**Stage 3 acceptance (Logic integration):**
- `CreateShomiti` use case creates `Shomiti` + initial `RuleSetVersion`.
- Validation: no invalid combinations (e.g., transfer allowed must require unanimous approval policy).
- Store the active `ruleSetVersionId` on Shomiti.

**Tests:**
- Unit: rule snapshot immutability; policy selection validation.
- Patrol: complete wizard (happy path) + validation errors.
- E2E: “fresh install → setup wizard → dashboard shows active shomiti”.

---

### TS-102 — Member Sign-Off + Roles
**Goal:** Assign Coordinator/Treasurer/Auditor roles and capture member sign-off (consent).  
**Depends on:** TS-101.  
**Rules coverage:** 4, 18.

**Key UI:**
- Roles assignment screen (minimum: Treasurer + Auditor must exist).
- Sign-off capture screen (per member consent/proof record).

**Stage 3 acceptance (Logic integration):**
- `AssignRole` and `RecordMemberConsent` use cases.
- Enforce “two-person verification capability”: payout approvals must be possible (Treasurer + Auditor).

**Tests:**
- Unit: cannot mark governance “ready” without required roles.
- Patrol: assign roles and record consent.
- E2E: setup wizard → roles/sign-off → ready state shown.

---

### TS-103 — Rules Viewer (Current Rules + version)
**Goal:** Read-only view of active RuleSetVersion to enable transparency.  
**Depends on:** TS-101.  
**Rules coverage:** 2, 12, 15.

**Key UI:**
- Rules summary screen (setup fields + policies).
- Show `RuleSetVersion` id + createdAt + who approved.

**Tests:**
- Widget: renders correctly for populated rules.
- Patrol/E2E: view rules from dashboard.

---

### TS-201 — Members CRUD (Identity + Contact + Emergency)
**Goal:** Member management with identity/contact info and privacy-safe display.  
**Depends on:** TS-101..TS-103.  
**Rules coverage:** 3, 16.

**Key UI:**
- Members list + add/edit/detail.
- Capture: full name, phone, address/workplace, optional NID/passport, emergency contact.
- Status: active/removed.

**Stage 3 acceptance (Logic integration):**
- `AddMember`, `UpdateMember`, `DeactivateMember` use cases.
- Dedupe guardrails: prevent duplicate “one person, one identity” (phone/NID) with explicit resolution flow.
- Ensure exports/screens do not expose sensitive fields by default (masking policy).

**Tests:**
- Unit: dedupe and validation rules.
- Patrol: CRUD flow.
- E2E: add at least 3 members.

---

### TS-202 — Shares Management (Single/Multiple Shares)
**Goal:** Allocate shares per member, enforce caps, compute pot basics.  
**Depends on:** TS-201 + TS-101.  
**Rules coverage:** 5, 10.

**Key UI:**
- Assign shares screen: member → share count
- Show computed totals: total shares, monthly pot estimate

**Stage 3 acceptance (Logic integration):**
- `AssignSharesToMember` use case enforces max shares policy.
- Shares are immutable after cycle start (unless amendment rules allow).

**Tests:**
- Unit: max share enforcement; pot calculation correctness.
- Patrol/E2E: assign shares and see pot totals update.

---

### TS-203 — Guarantor / Security Deposit
**Goal:** Capture risk controls required for default prevention.  
**Depends on:** TS-201.  
**Rules coverage:** 9.3.

**Key UI:**
- Per-member guarantor record or security deposit record (proof attachment).

**Stage 3 acceptance (Logic integration):**
- `RecordGuarantorOrDeposit` use case.
- If policy requires it, block cycle start until all members comply.

**Tests:**
- Unit: enforcement of “required before start”.
- Patrol/E2E: record guarantor for one member and deposit for another.

---

### TS-204 — Exit, Replacement, Removal (Governance ops)
**Goal:** Handle mid-cycle exit/replacement and removal for misconduct with proper approvals and settlement records.  
**Depends on:** TS-201..TS-203.  
**Rules coverage:** 14.

**Key UI:**
- Replacement wizard: choose leaving member → proposed replacement → approvals → settlement summary.
- Removal flow: reason + unanimous approvals + final settlement record.

**Stage 3 acceptance (Logic integration):**
- `ReplaceMember` use case:
  - requires all dues to date settled
  - requires replacement acceptance of rules + required guarantees
  - records a written record/proof
- `RemoveMemberForMisconduct` use case:
  - requires unanimous vote
  - records settlement decision

**Tests:**
- Unit: cannot exit without replacement unless policy explicitly allows (default: disallow).
- Patrol/E2E: replace a member on a non-critical month in a seeded scenario.

---

### TS-301 — Monthly Dues Generation + Calendar
**Goal:** Generate monthly dues per share/member and provide month navigation.  
**Depends on:** TS-101..TS-202.  
**Rules coverage:** 6, 17.

**Key UI:**
- Month selector (BillingMonth).
- Dues list per member/share with due/paid status.

**Stage 3 acceptance (Logic integration):**
- `CreateMonthlyDues` use case uses `RuleSetVersion` (share value, shares) to compute dues.
- Handle cycle length and end-of-cycle behavior.

**Tests:**
- Unit: due computations and month boundaries.
- Patrol/E2E: generate dues for current month and navigate to next/previous month.

---

### TS-302 — Record Payments + Receipts
**Goal:** Record contributions with proof and issue receipts.  
**Depends on:** TS-301 + TS-201.  
**Rules coverage:** 6, 12.

**Key UI:**
- Payment entry: amount, method, reference, attach proof (screenshot/file)
- Receipt view and audit log line item

**Stage 3 acceptance (Logic integration):**
- `RecordPayment` + `IssueReceipt` use cases.
- Enforce allowed payment methods and receipt requirement.

**Tests:**
- Unit: payment method validation; receipt creation.
- Patrol/E2E: record payment for at least two members and confirm status updates.

---

### TS-303 — Late Fees + Eligibility Gate
**Goal:** Late payment policy enforcement and draw eligibility based on confirmed payment.  
**Depends on:** TS-302.  
**Rules coverage:** 7.2, 9.1.

**Key UI:**
- Late status badge, late fee computed and visible
- Eligibility view per month (who is eligible)

**Stage 3 acceptance (Logic integration):**
- `ApplyLateFee` use case per policy.
- Eligibility calculation excludes unpaid/unconfirmed members/shares for that month.

**Tests:**
- Unit: grace period and late fee math.
- E2E: mark one member unpaid → ensure they are excluded from draw eligibility.

---

### TS-304 — Short Pot Handling Policies
**Goal:** Enforce “no partial payout” and implement Section 9.2 A/B/C short pot policies.  
**Depends on:** TS-302 + TS-303.  
**Rules coverage:** 6.5, 9.2.

**Key UI:**
- “Collection status” screen for the month:
  - total due vs collected
  - actions depending on A/B/C policy (postpone / reserve / guarantor cover)

**Stage 3 acceptance (Logic integration):**
- `VerifyAndCloseMonthlyCollection` use case enforces:
  - Policy A: no payout until full collection
  - Policy B: reserve temporarily covers; defaulter repays reserve
  - Policy C: guarantor cover within configured window

**Tests:**
- Unit: each policy branch behavior.
- E2E: short pot scenario for selected policy.

---

### TS-305 — Default Management + Enforcement Steps
**Goal:** Detect defaults (especially post-win) and execute enforcement steps consistently and equally for all members.  
**Depends on:** TS-203 + TS-304.  
**Rules coverage:** 9.3.

**Key UI:**
- Defaults dashboard: who is in default, thresholds (missed count), next enforcement step
- Enforcement action log (reminder → notice → guarantor/deposit → dispute)

**Stage 3 acceptance (Logic integration):**
- `MarkDefault` + `RecordEnforcementStep` use cases.
- Applies policies uniformly (no organizer exceptions).
- Integrates with guarantor/deposit records and dispute workflow linkage.

**Tests:**
- Unit: default thresholds; enforcement sequence ordering.
- E2E: “member wins early → stops paying → enforcement steps triggered”.

---

### TS-401 — Eligibility Computation + Draw Recording
**Goal:** Run and record monthly draw fairly and audibly, one win per share per cycle.  
**Depends on:** TS-303 + TS-304.  
**Rules coverage:** 7.

**Key UI:**
- Eligible shares list (snapshot)
- Run draw screen: choose method (allowed), record result, attach proof

**Stage 3 acceptance (Logic integration):**
- `ComputeEligibleSharesForMonth` + `RunDraw` use cases.
- Winner share is removed from future draws until next cycle.
- Store draw inputs + output proof artifacts (hash/seed if digital).

**Tests:**
- Unit: one-win-per-share; eligibility correctness.
- E2E: run draw on a month with all paid.

---

### TS-402 — Witness Sign-Off + Redo Flow
**Goal:** Enforce witness confirmations and allow redo when compromised.  
**Depends on:** TS-401.  
**Rules coverage:** 7.

**Key UI:**
- Witness confirmation screen (min 2)
- Redo action with reason and audit trail

**Stage 3 acceptance (Logic integration):**
- `RecordDrawWitnessApproval` and `InvalidateDrawAndRedo` use cases.
- Redo creates a linked draw record; original remains for audit.

**Tests:**
- Unit: cannot finalize draw without witness approvals.
- E2E: simulate redo and ensure final draw is the effective one.

---

### TS-403 — Payout Approval Flow + Proof
**Goal:** Execute payout only when collection is verified, with two-person verification and proof.  
**Depends on:** TS-304 + TS-402.  
**Rules coverage:** 4, 5.4, 8.

**Key UI:**
- Payout screen: verify full collection → treasurer approval → auditor approval → record payout proof

**Stage 3 acceptance (Logic integration):**
- `ApprovePayout` use case requires Treasurer + Auditor approvals.
- `RecordPayoutProof` stores transaction reference/attachment.
- Winner remains obligated to pay future months.

**Tests:**
- Unit: cannot payout if collection is short under Policy A.
- E2E: run draw → payout → winner still appears in future dues list.

---

### TS-501 — Ledger View + Monthly Statement Generation
**Goal:** Provide transparent ledger and generate monthly statements.  
**Depends on:** TS-403 + TS-003.  
**Rules coverage:** 12, 17.

**Key UI:**
- Ledger entries list (filter by month/type)
- Monthly statement screen (summary totals + proof links)

**Stage 3 acceptance (Logic integration):**
- `GenerateMonthlyStatement` derives statement from ledger entries.
- Statement includes: member list, shares, due/paid, pot total, winner, payout proof.

**Tests:**
- Data tests: statement totals match ledger sums.
- E2E: after payout, generate statement and verify contains winner + proof.

---

### TS-502 — Statement Sign-Off (Auditor/Witness)
**Goal:** Require sign-off for monthly statements to complete the month.  
**Depends on:** TS-501.  
**Rules coverage:** 4, 12, 17.

**Key UI:**
- Sign-off action (auditor/witness) with proof
- “Month complete” status indicator

**Tests:**
- Unit: cannot close month without sign-off (if policy requires).
- E2E: statement generated → sign-off → checklist shows complete.

---

### TS-503 — Rule Amendments + Unanimous Consent
**Goal:** Amend rules with proper voting/consent and immutable versioning.  
**Depends on:** TS-101 + TS-103.  
**Rules coverage:** 15.

**Key UI:**
- Propose amendment (diff view)
- Collect consents (majority/unanimous depending on timing/policy)
- Activate new version + show history

**Stage 3 acceptance (Logic integration):**
- Amendments create a new `RuleSetVersion`; old remains immutable.
- After start, critical changes require unanimous consent (enforced by domain).

**Tests:**
- Unit: consent requirements (before vs after start).
- E2E: propose amendment → collect unanimous → activate → rules viewer shows new version.

---

### TS-504 — Disputes Workflow
**Goal:** Track disputes and resolution steps without harassment/shaming language.  
**Depends on:** TS-501 (ledger references).  
**Rules coverage:** 13, 16.

**Key UI:**
- Dispute list + create dispute
- Attach evidence (files/notes)
- Resolution steps timeline

**Tests:**
- Unit: dispute state transitions.
- E2E: open dispute → add evidence → close dispute.

---

### TS-601 — Exports (PDF/CSV) + Redaction + Consent Gates
**Goal:** Export statements/ledgers safely with privacy defaults and consent requirements.  
**Depends on:** TS-501..TS-502.  
**Rules coverage:** 12, 16.

**Key UI:**
- Export screen: choose month/report type, choose format, redaction options, consent acknowledgements

**Stage 3 acceptance (Logic integration):**
- `ExportStatement` use case applies redaction policy by default.
- Explicit consent gates before including sensitive fields.

**Tests:**
- Unit: redaction rules.
- E2E: export statement (redacted) from completed month.

---

### TS-602 — Operational Monthly Checklist Dashboard
**Goal:** Guided monthly operations aligning exactly with `rules.md` Section 17.  
**Depends on:** TS-302..TS-502.  
**Rules coverage:** 17.

**Key UI:**
- Checklist with step statuses and deep links:
  1) attendance/proxies
  2) confirm payments / apply short pot policy
  3) run draw + witnesses
  4) payout approvals + proof
  5) publish statement + sign-off

**Tests:**
- Patrol: checklist navigates to correct screens.
- E2E: full month workflow through checklist.

---

### TS-603 — Performance/Accessibility/Localization Pass
**Goal:** Hardening for long-term maintainability and real-world deployment.  
**Depends on:** all MVP tasks.  
**Rules coverage:** 16 (conduct + safety language), plus quality baseline.

**Acceptance:**
- Accessibility labels and focus order for key screens.
- Localized strings foundation (`intl`) and consistent copy tone.
- Performance baseline (avoid unnecessary rebuilds, list virtualization).

**Tests:**
- Widget tests for a11y semantics on key screens.
- E2E smoke remains stable across targets.

---

## D) E2E Scenario Registry (MVP)

Each new task should add/extend E2E tests incrementally so “main” always has a growing safety net.

1) **E2E-01 Setup to Ready**
   - TS-101, TS-102, TS-103
2) **E2E-02 Members + Shares**
   - TS-201, TS-202, TS-203
3) **E2E-03 Monthly Collection**
   - TS-301, TS-302, TS-303, TS-304
4) **E2E-04 Draw + Witness + Payout**
   - TS-401, TS-402, TS-403
5) **E2E-05 Statement + Sign-Off**
   - TS-501, TS-502
6) **E2E-06 Amend Rules**
   - TS-503
7) **E2E-07 Dispute**
   - TS-504
8) **E2E-08 Export (Redacted)**
   - TS-601
9) **E2E-09 Guided Monthly Checklist**
   - TS-602
10) **E2E-10 Default After Winning**
   - TS-305
11) **E2E-11 Exit/Replacement**
   - TS-204

---

## E) Optional / Post‑MVP Tasks (schedule after MVP is stable)

These are architecture-supported (see `architecture.md`) but not required to satisfy the base `rules.md` template.

- **TS-701** Encrypted Backup / Restore (local file export/import)
- **TS-702** Multi-device Sync (remote data source + conflict strategy)
- **TS-703** Share Transfer Feature (if enabled by policy; requires unanimous approvals)
- **TS-704** Device App Lock (PIN/Biometrics) and session timeout
- **TS-705** Release automation (build flavors, versioning strategy, store metadata)


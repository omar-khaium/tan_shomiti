# Tan Shomiti App Architecture

This document plans a **production-grade Flutter app architecture** for managing a **Tan Shomiti (ROSCA)** in a way that is **100% compliant with `rules.md`** (the rules book is the **source of truth** for business behavior).

## 1) Product Goals (What the app must do)

- Make a Shomiti easy to set up (members, shares, schedule, policies).
- Enforce the rules consistently (eligibility, draw, payout, default handling).
- Keep an **auditable ledger** and **monthly statement** with proofs.
- Support **role separation** and **two-person verification** (Treasurer + Auditor).
- Respect **privacy** (personal info minimization, consent, secure storage, safe exports).
- Scale from “single device, coordinator-run” to “multi-device sync” without rewriting core logic.

Non-goals (for MVP):
- Legal enforcement; the app documents rules and actions but does not replace contracts/legal advice.
- Banking features; payouts/payments are recorded with proofs, not executed by the app (unless later integrated).

---

## 2) Architectural Style & State Management

### 2.1 Clean Architecture (feature-first)

We use **Clean Architecture** with strict boundaries:

`UI (Flutter Widgets)` → `State (Controllers)` → `Domain (Entities + Use Cases)` → `Data (Repositories + Data Sources)`

Rules:
- **Domain is pure Dart** (no Flutter imports).
- **Presentation depends on Domain** (never on Data).
- **Data depends on Domain** by implementing repository interfaces.
- Communication across layers uses **typed results**, not “stringly-typed” errors.

### 2.2 State management & DI choice: Riverpod

Use **Riverpod (v2+)** for:
- predictable, testable state (`Notifier` / `AsyncNotifier`)
- dependency injection (providers) without global singletons
- easy overriding in tests and clean composition across features

Riverpod is chosen because it naturally doubles as DI + state while staying compatible with Clean Architecture boundaries (controllers talk to use-cases; repos are injected).

---

## 3) High-level Module Map

**Core modules (features):**
- `shomiti_setup`: create group + initial rules/policies
- `members`: member profiles, identity/contact, roles, guarantor/security
- `shares`: shares per member, cap rules, (optional) share transfer with unanimous approval
- `contributions`: monthly dues, payment records, receipts/proofs, late fees
- `draws`: eligibility checks, draw event recording, witnesses, proof generation
- `payouts`: payout approval flow, payout proof, enforcement of “no payout when short” unless policy says otherwise
- `ledger`: append-only ledger + monthly statements + audit sign-off
- `rules`: rule versions/amendments + consent tracking
- `disputes`: dispute log + resolution steps
- `reports_export`: exports (PDF/CSV) with redaction + consent safeguards
- `settings_security`: device security, backup/sync toggles, data retention

**Cross-cutting (core):**
- `core/error`: typed failures
- `core/result`: `Result<T>` (sealed) for success/failure
- `core/security`: encryption key mgmt, redaction helpers
- `core/time`: “month” abstractions and timezone-safe dates
- `core/audit`: audit events (who/when/what/proof)

---

## 4) Folder Structure (Recommended)

```
lib/
  main.dart
  src/
    app/
      app.dart
      router.dart
      bootstrap.dart
    core/
      audit/
      error/
      result/
      security/
      time/
      ui/
    features/
      shomiti_setup/
        data/
        domain/
        presentation/
      members/
        data/
        domain/
        presentation/
      contributions/
        data/
        domain/
        presentation/
      draws/
        data/
        domain/
        presentation/
      payouts/
        data/
        domain/
        presentation/
      ledger/
        data/
        domain/
        presentation/
      rules/
        data/
        domain/
        presentation/
      disputes/
        data/
        domain/
        presentation/
      reports_export/
        data/
        domain/
        presentation/
```

Each feature contains:
- `domain/`: entities, value objects, policies, repository interfaces, use cases
- `data/`: DTOs, mappers, repository implementations, local/remote sources
- `presentation/`: pages/widgets + controllers (Riverpod notifiers)

---

## 5) Domain Design (Rules-driven)

### 5.1 Key domain entities (immutable)

Core:
- `Shomiti`: id, name, startDate, status, meetingSchedule, payoutMethod, groupChannel, ruleSetVersionId
- `RuleSetVersion`: immutable snapshot of all policies/parameters in force
- `Member`: identity + contact, role(s), emergency contact, status (active/removed), joinedAt
- `Share`: shareId, memberId, cycleId, status (available/won/transferred), winMonth?
- `Cycle`: startMonth, lengthMonths, totalShares, status

Operational:
- `MonthlyContribution`: month, memberId/shareId, dueAmount, paidAmount, status, paymentProofs
- `PaymentReceipt`: method, reference, timestamp, attachment (screenshot/file hash), issuer (treasurer)
- `DrawEvent`: month, eligibleShareIds, winnerShareId, method, witnesses, drawProof
- `Payout`: month, amount, winnerMemberId/shareId, approvals, payoutProof
- `LedgerEntry`: append-only record of all money-in/money-out + relevant metadata
- `MonthlyStatement`: computed + signed view derived from ledger entries

Risk & governance:
- `Guarantor`: memberId, guarantorName, contact, acceptedAt, proof
- `SecurityDeposit`: memberId, amount, heldBy, status, proof
- `Approval`: approverMemberId, role, timestamp, proof (signature/OTP/chat proof)
- `Dispute`: raisedBy, month?, description, status, resolutionSteps, attachments
- `Amendment`: proposedRuleDiff, votes/consents, effectiveAt, signedRecord

### 5.2 Value objects (avoid primitive obsession)

- `MoneyBdt` (int minor units; currency locked to BDT for this app)
- `BillingMonth` (year + month; no timezone bugs)
- `MemberId`, `ShomitiId`, `ShareId`, `CycleId`
- `PhoneNumber`, `NonEmptyString`
- `Percentage`, `LateFeePolicy`, `GracePeriod`, `Deadline`

### 5.3 Policies (configurable via RuleSetVersion)

`RuleSetVersion` contains all policies that correspond to `rules.md` “fill-ins” and “choose one” parts, for example:
- `GroupTypePolicy`: `closed` / `open` (+ constraints)
- `SharesPolicy`: maxSharesPerPerson, allowTransfers, transferRequiresUnanimous
- `ContributionPolicy`: shareValue, paymentDeadline, allowedMethods, partialPayoutAllowed=false
- `DrawPolicy`: methodAllowed (physical/tokens/randomizer), eligibilityRequiresConfirmedPayment=true
- `MissedPaymentPolicy`: `postponePayout` | `coverFromReserve` | `coverByGuarantor`
- `LatePaymentPolicy`: gracePeriod, lateFee (flat per day or percent)
- `DefaultPolicy`: definition thresholds + enforcement steps
- `FeesPolicy`: feeAmount, payerModel
- `RuleChangePolicy`: beforeStart vote type, afterStart requiresUnanimous=true
- `PrivacyPolicy`: exportRedaction defaults, consent requirements

**Important:** A rule change creates a **new `RuleSetVersion`** (never edits the old one), so historical actions remain auditable under the rules that were active at the time.

---

## 6) Use Cases (Application Services)

Use cases are the only way Presentation can change Domain state. Examples:

Setup & governance:
- `CreateShomiti`
- `StartCycle`
- `ProposeRuleAmendment`
- `CollectMemberConsentsForAmendment`
- `ActivateRuleSetVersion`

Members & roles:
- `AddMember`
- `AssignRole` (Coordinator/Treasurer/Auditor)
- `RecordGuarantorOrDeposit`
- `ReplaceMember` (with approvals + settlement)
- `RemoveMemberForMisconduct` (unanimous vote + documented settlement)

Contributions & receipts:
- `CreateMonthlyDues`
- `RecordPayment`
- `IssueReceipt`
- `ApplyLateFee`
- `MarkPaymentConfirmed` (Treasurer + Auditor or configured verification)

Draws & payouts:
- `ComputeEligibleSharesForMonth`
- `RunDraw` (records method + proof; witnesses required)
- `VerifyAndCloseMonthlyCollection`
- `ApprovePayout` (two-person verification)
- `RecordPayoutProof`

Accounting & transparency:
- `AppendLedgerEntry`
- `GenerateMonthlyStatement`
- `SignOffMonthlyStatement` (Auditor/Witness)
- `ExportStatement` (with redaction policy)

Disputes:
- `OpenDispute`
- `AttachEvidence`
- `RecordResolutionStep`
- `CloseDispute`

All use cases must:
- validate invariants from `rules.md`
- produce audit events
- return `Result<T>` with typed failures

---

## 7) Data Layer (Local-first, Sync-ready)

### 7.1 Repositories

Domain defines repository interfaces (examples):
- `ShomitiRepository`
- `MemberRepository`
- `ContributionRepository`
- `DrawRepository`
- `PayoutRepository`
- `LedgerRepository`
- `RulesRepository`
- `DisputeRepository`
- `AuditRepository`

Data implements them using:
- `LocalDataSource` (SQLite/Drift or Isar) as **source of truth**
- `RemoteDataSource` (optional) for backup/sync

### 7.2 Storage strategy

Default approach:
- **Local-only** operation with secure storage and export/share features.
- **Append-only ledger** + audit events to preserve integrity.

Optional upgrades:
- Encrypted backups (local file export)
- Cloud sync (e.g., Firebase/Supabase/custom API) behind `RemoteDataSource`

### 7.3 Security

Because `rules.md` includes personal info + financial records:
- Encrypt at rest where feasible (DB encryption or encrypt export files).
- Store encryption keys in platform keystore (`flutter_secure_storage`).
- Redact exports by default (mask NID/passport, partial phone number).
- Explicit consent gates before sharing identifiable info.

---

## 8) Presentation Layer (Screens, Flows, State)

### 8.1 Navigation (example)

- Setup Wizard
  - Create Shomiti → Add Members → Assign Roles → Configure Policies → Confirm & Start
- Home Dashboard
  - This month status (paid/short), draw eligibility, payout status, checklist
- Members
  - list + detail (identity, contact, guarantor/deposit, roles, status)
- Contributions
  - month view + record payment + attach receipt proof
- Draw
  - eligibility list → run draw → witness sign → publish draw proof
- Payout
  - verify full collection → treasurer approve → auditor approve → record payout proof
- Ledger/Statements
  - append-only ledger + monthly statement generator + auditor sign-off
- Rules & Amendments
  - view current RuleSetVersion + propose amendment + collect consents
- Disputes
  - open dispute + evidence + resolution steps
- Exports
  - monthly statement PDF/CSV, privacy settings

### 8.2 Controllers (Riverpod)

Pattern:
- each screen uses a `Notifier/AsyncNotifier` controller
- controller depends only on use cases (domain) injected via providers
- UI reacts to `state` and calls intent methods (no business logic in widgets)

Example controller responsibilities:
- validate UI inputs (format-level only)
- call a use case
- map domain failures to UI messages
- trigger navigation/snackbars via UI layer (not domain)

---

## 9) Audit Trail & Transparency (Rules sections 12 & 17)

To support “everyone can verify collections, draw, and payouts”:
- Every mutation writes an `AuditEvent` (actor, role, action, timestamp, metadata hash).
- Every payment has a `PaymentReceipt` proof record.
- Every draw stores:
  - eligible list snapshot
  - winner
  - method (physical/tokens/randomizer)
  - witness approvals
  - `drawProof` (see below)
- Every payout stores:
  - verification status (“full collection confirmed?”)
  - two-person approvals
  - payout proof (transaction screenshot/reference)

### 9.1 Draw proof (digital method)

If using a “simple randomizer”, the app must be auditable:
- store the random seed, algorithm version, and the eligible list ordering
- generate and store a hash of inputs → output (so members can verify later)
- optionally export a “draw certificate” that can be screen-recorded

If draw method is physical/tokens, the app records the result + witnesses + optional video/hash attachment.

---

## 10) Rule Changes & Versioning (Rules section 15)

Rules are immutable snapshots:
- `RuleSetVersion` is created at setup.
- Amendments create a new `RuleSetVersion`.
- After cycle start, “amounts/schedule/draw/enforcement” changes require **unanimous consent** (enforced by use cases).
- Amendments store:
  - who consented
  - when
  - proof (signature/OTP/chat proof reference)
  - effective date

---

## 11) Testing Strategy (CI-ready)

Priority order:
1. **Domain unit tests** (fast): invariants, policies, use cases (rules compliance).
2. **Data tests**: repository behavior, migrations, query correctness (monthly statement totals).
3. **Presentation tests**: controller tests with fake repositories; key widget tests.
4. **Integration tests**: “monthly flow” happy path + default scenarios.

Rules compliance tests:
- For each `rules.md` section, create “spec” tests that validate the invariants (see compliance matrix below).

---

## 12) `rules.md` Compliance Matrix (100% coverage)

This table maps each rules section to the architecture components that enforce it.

### 1) Shomiti Setup (Fill these in)
- **Data captured:** `RuleSetVersion` + `Shomiti` created by `CreateShomiti`
- **UI:** Setup Wizard feature (`shomiti_setup/presentation`)
- **Validation:** required fields, sensible ranges, and “closed recommended” default

### 2) Core Principles
- **Trust + transparency:** `AuditRepository`, `LedgerRepository`, exports + witness sign-offs
- **Fixed commitments:** cycle + membership policies enforced in domain use cases
- **Fairness:** auditable draw method + immutable history
- **Zero surprises:** rule versioning + amendment flow + explicit confirmations
- **Safety:** identity/guarantee captured + default policies implemented

### 3) Membership Rules
- **Eligibility & identity:** `Member` requires identity/contact; `AddMember` validates
- **One person, one identity:** dedupe checks (phone/NID) and explicit conflict resolution
- **Commitment:** `Member.status` + cycle lock rules (cannot stop obligations after winning)
- **Joining closed:** `GroupTypePolicy.closed` enforced by `AddMember` after start unless unanimous amendment

### 4) Roles & Responsibilities
- **Roles modeled:** `Role` enum on `Member`
- **Two-person verification:** `ApprovePayout` requires Treasurer + Auditor approvals
- **Oversight:** `SignOffMonthlyStatement` required before “month complete”

### 5) Shares & Pot Rules
- **Fixed shares:** `SharesPolicy` sets total shares at start; locked for cycle
- **No selling/transfers (recommended):** default `allowTransfers=false`
- **If transfers allowed:** `TransferShare` use case requires unanimous approvals + new holder acceptance
- **Pot definition:** computed from `N × S × shares` in `RuleSetVersion` and `Cycle`
- **Pot paid only when full collection confirmed:** enforced by `VerifyAndCloseMonthlyCollection` + `ApprovePayout`

### 6) Monthly Contribution Rules
- **Due amount:** computed per share in `CreateMonthlyDues`
- **Deadline:** stored in `RuleSetVersion`; used by `ApplyLateFee` and eligibility
- **Payment methods:** validated in `RecordPayment`
- **Receipts:** `IssueReceipt` persists `PaymentReceipt` with proof
- **No partial pot payout:** enforced unless `MissedPaymentPolicy` covers shortfall

### 7) Draw (Lottery) Rules
- **Schedule:** `meetingSchedule` + `BillingMonth` calendar
- **Eligibility:** `ComputeEligibleSharesForMonth` checks payment confirmation
- **One win per share:** share status transitions `available → won`; removed from future eligibility
- **Integrity:** draw method recorded + proof + witness approvals
- **Witnesses:** required in `RunDraw` (min 2) and stored as `Approval`
- **Proxy/attendance:** `Approval` can record “proxy for X” with proof reference
- **Tie/redo:** `RunDraw` can be invalidated; audit event records reason + redo linkage

### 8) Payout Rules
- **Timing:** stored target SLA; payout can be “scheduled/within X hours”
- **Amount:** full pot minus pre-agreed fees; computed in domain
- **Proof:** `RecordPayoutProof` requires transaction reference/attachment
- **Winner continues obligations:** domain prevents stopping dues after winning
- **No forced use:** UI copy + no restrictions in domain logic

### 9) Late Payment, Missed Payment, and Default
- **Grace period + late fee:** `LatePaymentPolicy` + `ApplyLateFee`
- **Impact on draw:** eligibility checks exclude unpaid shares
- **Short pot policy:** `MissedPaymentPolicy` selects A/B/C behavior in `VerifyAndCloseMonthlyCollection`
- **Security/guarantee:** `RecordGuarantorOrDeposit` required before start when configured
- **Default definition & enforcement steps:** `DefaultPolicy` + `MarkDefault` + `EnforcementStep` log
- **No exceptions:** policies apply uniformly; role does not bypass

### 10) Multiple Shares per Person (Optional)
- **Max shares:** enforced in `AssignSharesToMember`
- **Draw eligibility per share:** eligibility computed per shareId
- **Win frequency rule:** optional policy enforced in `RunDraw` eligibility filter
- **Payments proportional:** dues computed as `S × shares`

### 11) Fees, Costs, and Compensation (Optional)
- **Fee definition:** `FeesPolicy` inside `RuleSetVersion`
- **Who pays:** computed allocation rule in domain
- **No hidden charges:** any fee must exist in active `RuleSetVersion` to be applied

### 12) Records & Transparency
- **Ledger:** `LedgerEntry` is append-only; queries generate statements
- **Monthly statement within 24h:** UI checklist + `GenerateMonthlyStatement`
- **Access:** export + on-device viewing; role gates for edits, not for viewing summary
- **Audit sign-off:** `SignOffMonthlyStatement` required and stored

### 13) Disputes & Resolution
- **Workflow:** `Dispute` feature logs the steps in order; evidence attachments supported
- **Ledger review:** dispute screen links to relevant ledger entries and proofs
- **Mediation/legal:** recorded as resolution steps and notes (no legal advice)

### 14) Exit, Replacement, and Removal
- **No exit without replacement:** `ReplaceMember` requires approvals + settled dues
- **Removal for misconduct:** `RemoveMemberForMisconduct` requires unanimous vote + settlement record
- **Replacement acceptance:** replacement member must accept active rules + provide required guarantee

### 15) Rule Changes
- **Before start:** policy chooses majority/unanimous and is enforced by `ProposeRuleAmendment`
- **After start:** unanimous is enforced for critical rule categories
- **Written record:** amendments stored with timestamp + proofs + exportable record

### 16) Privacy & Conduct
- **Privacy:** redaction + consent checks in `ExportStatement`
- **No harassment/shaming:** app language + reporting; disputes handled via structured workflow
- **Safety:** “prefer digital transfers for large amounts” shown as guidance; payout method configurable

### 17) Monthly Checklist (Operational)
- **Checklist feature:** a guided monthly flow:
  1) confirm attendance/proxies
  2) confirm payments / apply missed-payment policy
  3) run draw with witnesses
  4) record winner + payout amount
  5) record payout proof
  6) publish ledger + monthly statement + sign-off

### 18) Sign-Off (Recommended)
- **Member consent:** `MemberConsent` records acceptance of initial rules and amendments
- **Proof:** signature/OTP/chat proof reference stored
- **UI:** join/setup includes explicit “I agree” confirmation and exportable sign-off list

---

## 13) Minimal Dependency Set (Suggested)

Not installed yet; these are architecture-aligned recommendations:
- State/DI: `flutter_riverpod`, `riverpod_annotation`, `build_runner`
- Immutability: `freezed`, `freezed_annotation`
- Serialization: `json_serializable`, `json_annotation`
- Navigation: `go_router`
- Local DB: `drift` + `sqlite3_flutter_libs` (or `isar` if preferred)
- Security: `flutter_secure_storage`, `cryptography` (hashing/proofs)
- Testing: `mocktail`
- Localization: `intl`

---

## 14) Implementation Order (Pragmatic roadmap)

1) Domain foundation: value objects + RuleSetVersion + key invariants (rules compliance tests)
2) Local persistence + repositories (ledger, members, rules)
3) Monthly flow MVP (contributions → draw → payout → statement)
4) Exports + privacy safeguards
5) Disputes + amendments
6) Optional remote sync/backup


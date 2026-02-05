import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../contributions/domain/value_objects/billing_month.dart';
import '../../../contributions/presentation/providers/contributions_domain_providers.dart';
import '../../../draw/presentation/providers/draw_domain_providers.dart';
import '../../../members/presentation/providers/members_providers.dart';
import '../../../payments/presentation/providers/payments_domain_providers.dart';
import '../models/payout_ui_state.dart';
import '../providers/payout_context_providers.dart';
import '../providers/payout_domain_providers.dart';

class PayoutController extends AutoDisposeAsyncNotifier<PayoutUiState> {
  BillingMonth? _month;

  @override
  Future<PayoutUiState> build() async {
    _month ??= BillingMonth.fromDate(DateTime.now());
    return _load();
  }

  Future<PayoutUiState> _load() async {
    final context = await ref.watch(payoutContextProvider.future);
    final month = _month!;

    if (context == null) {
      return PayoutUiState(
        shomitiId: 'unknown',
        ruleSetVersionId: 'unknown',
        month: month,
        drawId: null,
        winnerLabel: '—',
        amountBdt: 0,
        totals: const PayoutCollectionTotalsUiState(
          dueTotalBdt: 0,
          paidTotalBdt: 0,
          coveredTotalBdt: 0,
          shortfallBdt: 0,
        ),
        verification: const PayoutVerificationUiState(
          isVerified: false,
          verifiedByMemberId: null,
          verifiedByName: null,
          verifiedAt: null,
        ),
        treasurerApproval: const PayoutRoleApprovalUiState(
          hasApproval: false,
          approverMemberId: null,
          approverName: null,
          approvedAt: null,
          note: null,
        ),
        auditorApproval: const PayoutRoleApprovalUiState(
          hasApproval: false,
          approverMemberId: null,
          approverName: null,
          approvedAt: null,
          note: null,
        ),
        paid: const PayoutPaidUiState(
          isPaid: false,
          proofReference: null,
          paidAt: null,
        ),
        allowShortfallCoverage: false,
        prerequisites: const PayoutPrerequisitesUiState(
          hasRecordedDraw: false,
          isDrawFinalized: false,
          isCollectionComplete: false,
          isCollectionVerified: false,
          hasTreasurerApproval: false,
          hasAuditorApproval: false,
        ),
      );
    }

    final draw = await ref.watch(drawRecordsRepositoryProvider).getEffectiveForMonth(
      shomitiId: context.shomitiId,
      month: month,
    );

    final dues = await ref
        .watch(monthlyDuesRepositoryProvider)
        .listMonthlyDues(shomitiId: context.shomitiId, month: month);
    final dueTotal = dues.fold<int>(0, (sum, d) => sum + d.dueAmountBdt);

    final payments = await ref
        .watch(paymentsRepositoryProvider)
        .watchPaymentsForMonth(shomitiId: context.shomitiId, month: month)
        .first;
    final paidTotal = payments.fold<int>(0, (sum, p) => sum + p.amountBdt);

    final resolution = await ref
        .watch(monthlyCollectionRepositoryProvider)
        .getResolution(shomitiId: context.shomitiId, month: month);
    final coveredTotal = resolution?.amountBdt ?? 0;

    final effectiveCollected = paidTotal + coveredTotal;
    final shortfall = dueTotal <= 0
        ? 0
        : (dueTotal - effectiveCollected).clamp(0, dueTotal);

    final payoutRepo = ref.watch(payoutRepositoryProvider);
    final verification = await payoutRepo.getCollectionVerification(
      shomitiId: context.shomitiId,
      month: month,
    );
    final approvals = await payoutRepo.listApprovals(
      shomitiId: context.shomitiId,
      month: month,
    );
    final payoutRecord = await payoutRepo.getPayoutRecord(
      shomitiId: context.shomitiId,
      month: month,
    );

    final members = await ref
        .watch(membersRepositoryProvider)
        .listMembers(shomitiId: context.shomitiId);
    final memberNameById = {for (final m in members) m.id: m.fullName};

    PayoutRoleApprovalUiState latestApprovalForRole(String roleName) {
      final items = approvals.where((a) => a.role.name == roleName).toList();
      if (items.isEmpty) {
        return const PayoutRoleApprovalUiState(
          hasApproval: false,
          approverMemberId: null,
          approverName: null,
          approvedAt: null,
          note: null,
        );
      }
      items.sort((a, b) => b.approvedAt.compareTo(a.approvedAt));
      final latest = items.first;
      return PayoutRoleApprovalUiState(
        hasApproval: true,
        approverMemberId: latest.approverMemberId,
        approverName: memberNameById[latest.approverMemberId],
        approvedAt: latest.approvedAt,
        note: latest.note,
      );
    }

    final treasurerApproval = latestApprovalForRole('treasurer');
    final auditorApproval = latestApprovalForRole('auditor');

    final winnerLabel = draw == null
        ? '—'
        : '${memberNameById[draw.winnerMemberId] ?? draw.winnerMemberId} (share ${draw.winnerShareIndex})';

    final verificationUi = verification == null
        ? const PayoutVerificationUiState(
            isVerified: false,
            verifiedByMemberId: null,
            verifiedByName: null,
            verifiedAt: null,
          )
        : PayoutVerificationUiState(
            isVerified: true,
            verifiedByMemberId: verification.verifiedByMemberId,
            verifiedByName: memberNameById[verification.verifiedByMemberId],
            verifiedAt: verification.verifiedAt,
          );

    final paidUi = payoutRecord == null
        ? const PayoutPaidUiState(isPaid: false, proofReference: null, paidAt: null)
        : PayoutPaidUiState(
            isPaid: payoutRecord.isPaid,
            proofReference: payoutRecord.proofReference,
            paidAt: payoutRecord.paidAt,
          );

    final prerequisites = PayoutPrerequisitesUiState(
      hasRecordedDraw: draw != null,
      isDrawFinalized: draw?.isFinalized ?? false,
      isCollectionComplete: dueTotal > 0 && shortfall == 0,
      isCollectionVerified: verification != null,
      hasTreasurerApproval: treasurerApproval.hasApproval,
      hasAuditorApproval: auditorApproval.hasApproval,
    );

    return PayoutUiState(
      shomitiId: context.shomitiId,
      ruleSetVersionId: context.ruleSetVersionId,
      month: month,
      drawId: draw?.id,
      winnerLabel: winnerLabel,
      amountBdt: dueTotal,
      totals: PayoutCollectionTotalsUiState(
        dueTotalBdt: dueTotal,
        paidTotalBdt: paidTotal,
        coveredTotalBdt: coveredTotal,
        shortfallBdt: shortfall,
      ),
      verification: verificationUi,
      treasurerApproval: treasurerApproval,
      auditorApproval: auditorApproval,
      paid: paidUi,
      allowShortfallCoverage: context.allowShortfallCoverage,
      prerequisites: prerequisites,
    );
  }

  Future<void> previousMonth() async {
    _month = (_month ?? BillingMonth.fromDate(DateTime.now())).previous();
    state = const AsyncValue.loading();
    state = AsyncValue.data(await _load());
  }

  Future<void> nextMonth() async {
    _month = (_month ?? BillingMonth.fromDate(DateTime.now())).next();
    state = const AsyncValue.loading();
    state = AsyncValue.data(await _load());
  }
}

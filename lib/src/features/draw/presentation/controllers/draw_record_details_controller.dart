import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../contributions/domain/value_objects/billing_month.dart';
import '../../../members/presentation/providers/members_providers.dart';
import '../models/draw_record_details_ui_state.dart';
import '../providers/draw_context_providers.dart';
import '../providers/draw_domain_providers.dart';

class DrawRecordDetailsController
    extends AutoDisposeAsyncNotifier<DrawRecordDetailsUiState?> {
  BillingMonth? _month;

  @override
  Future<DrawRecordDetailsUiState?> build() async {
    _month ??= BillingMonth.fromDate(DateTime.now());
    return _load();
  }

  Future<DrawRecordDetailsUiState?> _load() async {
    final context = await ref.watch(drawContextProvider.future);
    if (context == null) return null;

    final month = _month!;
    final record = await ref.watch(drawRecordsRepositoryProvider).getEffectiveForMonth(
      shomitiId: context.shomitiId,
      month: month,
    );

    if (record == null) {
      return DrawRecordDetailsUiState(
        month: month,
        hasRecord: false,
        drawId: null,
        methodLabel: null,
        proofReference: null,
        winnerLabel: null,
        statusLabel: null,
        witnessCount: 0,
      );
    }

    final member = await ref.watch(membersRepositoryProvider).getById(
      shomitiId: record.shomitiId,
      memberId: record.winnerMemberId,
    );
    final winnerName = member?.fullName ?? record.winnerMemberId;

    final approvals = await ref.watch(drawWitnessRepositoryProvider).listApprovals(
      drawId: record.id,
    );

    final methodLabel = switch (record.method.name) {
      'physicalSlips' => 'Physical slips',
      'numberedTokens' => 'Numbered tokens',
      _ => 'Simple randomizer',
    };
    final status = record.finalizedAt != null ? 'Finalized' : 'Pending witness sign-off';

    return DrawRecordDetailsUiState(
      month: month,
      hasRecord: true,
      drawId: record.id,
      methodLabel: methodLabel,
      proofReference: record.proofReference,
      winnerLabel: '$winnerName (share ${record.winnerShareIndex})',
      statusLabel: status,
      witnessCount: approvals.length,
    );
  }

  Future<void> previousMonth() async {
    _month = _month!.previous();
    state = const AsyncValue.loading();
    state = AsyncValue.data(await _load());
  }

  Future<void> nextMonth() async {
    _month = _month!.next();
    state = const AsyncValue.loading();
    state = AsyncValue.data(await _load());
  }
}


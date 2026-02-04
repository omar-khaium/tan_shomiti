import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../members/domain/entities/member.dart';
import '../models/shares_ui_state.dart';
import '../providers/shares_context_providers.dart';

class SharesController extends AutoDisposeAsyncNotifier<SharesUiState?> {
  Map<String, int>? _sharesByMemberId;
  SharesContext? _context;
  List<Member> _members = const [];

  @override
  Future<SharesUiState?> build() async {
    final context = await ref.watch(sharesContextProvider.future);
    if (context == null) return null;
    _context = context;

    final members = await ref
        .watch(sharesMembersRepositoryProvider)
        .listMembers(shomitiId: context.shomitiId);
    _members = members;

    _sharesByMemberId ??= _initialShares(
      members: members,
      totalShares: context.rules.cycleLengthMonths,
      maxSharesPerPerson: context.rules.maxSharesPerPerson,
    );

    _ensureMembersPresent(members);

    return _buildState();
  }

  void increment(String memberId) {
    final current = state.valueOrNull;
    if (current == null || _sharesByMemberId == null) return;

    final existing = _sharesByMemberId![memberId] ?? 1;
    if (existing >= current.maxSharesPerPerson) return;
    if (current.remainingShares <= 0) return;

    _sharesByMemberId![memberId] = existing + 1;
    state = AsyncValue.data(_buildState());
  }

  void decrement(String memberId) {
    final current = state.valueOrNull;
    if (current == null || _sharesByMemberId == null) return;

    final existing = _sharesByMemberId![memberId] ?? 1;
    if (existing <= 1) return;

    _sharesByMemberId![memberId] = existing - 1;
    state = AsyncValue.data(_buildState());
  }

  Map<String, int> _initialShares({
    required List<Member> members,
    required int totalShares,
    required int maxSharesPerPerson,
  }) {
    final result = <String, int>{for (final m in members) m.id: 1};
    var remaining = totalShares - members.length;
    if (remaining <= 0) return result;

    // Distribute extras from top to bottom (up to cap) to satisfy total shares.
    for (final member in members) {
      if (remaining <= 0) break;
      final current = result[member.id] ?? 1;
      final canAdd = maxSharesPerPerson - current;
      if (canAdd <= 0) continue;
      final add = remaining < canAdd ? remaining : canAdd;
      result[member.id] = current + add;
      remaining -= add;
    }

    return result;
  }

  void _ensureMembersPresent(List<Member> members) {
    final map = _sharesByMemberId!;
    for (final member in members) {
      map.putIfAbsent(member.id, () => 1);
    }
  }

  SharesUiState? _buildState() {
    final context = _context;
    final map = _sharesByMemberId;
    if (context == null || map == null) return null;

    return SharesUiState.from(
      shomitiId: context.shomitiId,
      ruleSetVersionId: context.ruleSetVersionId,
      rules: context.rules,
      members: _members,
      sharesByMemberId: map,
    );
  }
}

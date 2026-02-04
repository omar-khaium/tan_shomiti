import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/membership_change_ui_models.dart';

class DemoMembershipChangesStore
    extends Notifier<Map<String, MemberChangeStatus>> {
  @override
  Map<String, MemberChangeStatus> build() => <String, MemberChangeStatus>{};

  MemberChangeStatus statusFor(String memberId) =>
      state[memberId] ?? MemberChangeStatus.active;

  void requestExit(String memberId) {
    state = Map.unmodifiable({
      ...state,
      memberId: MemberChangeStatus.exitRequested,
    });
  }

  void proposeReplacement(String memberId) {
    state = Map.unmodifiable({
      ...state,
      memberId: MemberChangeStatus.replacementProposed,
    });
  }

  void removeForMisconduct(String memberId) {
    state = Map.unmodifiable({
      ...state,
      memberId: MemberChangeStatus.removedForMisconduct,
    });
  }
}

final demoMembershipChangesStoreProvider =
    NotifierProvider<
      DemoMembershipChangesStore,
      Map<String, MemberChangeStatus>
    >(DemoMembershipChangesStore.new);

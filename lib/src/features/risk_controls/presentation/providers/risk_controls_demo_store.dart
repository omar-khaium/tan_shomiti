import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class DemoGuarantor {
  const DemoGuarantor({
    required this.name,
    required this.phone,
    required this.relationship,
    required this.proofRef,
    required this.recordedAt,
  });

  final String name;
  final String phone;
  final String? relationship;
  final String? proofRef;
  final DateTime recordedAt;
}

@immutable
class DemoSecurityDeposit {
  const DemoSecurityDeposit({
    required this.amountBdt,
    required this.heldBy,
    required this.proofRef,
    required this.recordedAt,
    required this.returnedAt,
  });

  final int amountBdt;
  final String heldBy;
  final String? proofRef;
  final DateTime recordedAt;
  final DateTime? returnedAt;
}

@immutable
class DemoRiskControl {
  const DemoRiskControl({required this.guarantor, required this.deposit});

  final DemoGuarantor? guarantor;
  final DemoSecurityDeposit? deposit;

  bool get hasGuarantor => guarantor != null;
  bool get hasDepositHeld => deposit != null && deposit!.returnedAt == null;
  bool get hasDepositReturned => deposit?.returnedAt != null;
}

class DemoRiskControlsStore extends Notifier<Map<String, DemoRiskControl>> {
  @override
  Map<String, DemoRiskControl> build() => <String, DemoRiskControl>{};

  void recordGuarantor({
    required String memberId,
    required DemoGuarantor guarantor,
  }) {
    final current =
        state[memberId] ??
        const DemoRiskControl(guarantor: null, deposit: null);

    state = Map.unmodifiable({
      ...state,
      memberId: DemoRiskControl(guarantor: guarantor, deposit: current.deposit),
    });
  }

  void recordDeposit({
    required String memberId,
    required DemoSecurityDeposit deposit,
  }) {
    final current =
        state[memberId] ??
        const DemoRiskControl(guarantor: null, deposit: null);

    state = Map.unmodifiable({
      ...state,
      memberId: DemoRiskControl(guarantor: current.guarantor, deposit: deposit),
    });
  }
}

final demoRiskControlsStoreProvider =
    NotifierProvider<DemoRiskControlsStore, Map<String, DemoRiskControl>>(
      DemoRiskControlsStore.new,
    );

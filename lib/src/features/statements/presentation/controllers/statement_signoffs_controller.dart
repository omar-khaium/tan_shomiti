import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/statement_signoff_ui_model.dart';

class StatementSignoffsController
    extends AutoDisposeNotifier<List<StatementSignoffUiModel>> {
  @override
  List<StatementSignoffUiModel> build() => const [];

  void addSignoff({
    required String signerName,
    required StatementSignerRoleUi role,
    required String proofReference,
    required DateTime now,
  }) {
    state = [
      ...state,
      StatementSignoffUiModel(
        signerName: signerName,
        role: role,
        proofReference: proofReference,
        signedAt: now,
      ),
    ];
  }

  void removeAt(int index) {
    if (index < 0 || index >= state.length) return;
    final copy = state.toList(growable: true)..removeAt(index);
    state = List.unmodifiable(copy);
  }
}


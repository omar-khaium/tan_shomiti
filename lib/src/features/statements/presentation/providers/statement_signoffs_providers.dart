import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/statement_signoffs_controller.dart';
import '../models/statement_signoff_ui_model.dart';

final statementSignoffsControllerProvider = AutoDisposeNotifierProvider<
  StatementSignoffsController,
  List<StatementSignoffUiModel>
>(StatementSignoffsController.new);

enum StatementSignoffStatusUi { notSigned, partiallySigned, signed }

final statementSignoffStatusProvider = Provider<StatementSignoffStatusUi>((ref) {
  final signoffs = ref.watch(statementSignoffsControllerProvider);
  if (signoffs.isEmpty) return StatementSignoffStatusUi.notSigned;

  final auditorCount = signoffs.where((s) => s.role == StatementSignerRoleUi.auditor).length;
  final witnessCount = signoffs.where((s) => s.role == StatementSignerRoleUi.witness).length;

  if (auditorCount >= 1 || witnessCount >= 2) return StatementSignoffStatusUi.signed;
  return StatementSignoffStatusUi.partiallySigned;
});


import 'package:drift/drift.dart';

import '../../../core/data/local/app_database.dart';
import '../domain/entities/default_enforcement_step.dart';
import '../domain/repositories/defaults_repository.dart';

class DriftDefaultsRepository implements DefaultsRepository {
  DriftDefaultsRepository(this._db);

  final AppDatabase _db;

  @override
  Future<List<MemberDuePaymentRow>> listMemberDuePayments({
    required String shomitiId,
  }) async {
    final dues = _db.monthlyDues;
    final members = _db.members;
    final payments = _db.payments;

    final query = _db.select(dues).join([
      innerJoin(
        members,
        members.id.equalsExp(dues.memberId) & members.isActive.equals(true),
      ),
      leftOuterJoin(
        payments,
        payments.shomitiId.equalsExp(dues.shomitiId) &
            payments.monthKey.equalsExp(dues.monthKey) &
            payments.memberId.equalsExp(dues.memberId),
      ),
    ])
      ..where(dues.shomitiId.equals(shomitiId));

    final rows = await query.get();
    return rows
        .map((row) {
          final due = row.readTable(dues);
          final member = row.readTable(members);
          final payment = row.readTableOrNull(payments);

          return MemberDuePaymentRow(
            memberId: due.memberId,
            memberName: member.displayName,
            monthKey: due.monthKey,
            dueAmountBdt: due.dueAmountBdt,
            hasPayment: payment != null,
          );
        })
        .toList(growable: false);
  }

  @override
  Future<List<DefaultEnforcementStep>> listEnforcementSteps({
    required String shomitiId,
  }) async {
    final query = _db.select(_db.defaultEnforcementSteps)
      ..where((s) => s.shomitiId.equals(shomitiId))
      ..orderBy([
        (s) => OrderingTerm(expression: s.recordedAt),
        (s) => OrderingTerm(expression: s.id),
      ]);

    final rows = await query.get();
    return rows.map(_mapRow).toList(growable: false);
  }

  @override
  Future<void> addEnforcementStep(NewDefaultEnforcementStep step) async {
    await _db.into(_db.defaultEnforcementSteps).insert(
          DefaultEnforcementStepsCompanion.insert(
            shomitiId: step.shomitiId,
            memberId: step.memberId,
            episodeKey: step.episodeKey,
            stepType: step.type.name,
            ruleSetVersionId: step.ruleSetVersionId,
            recordedAt: step.recordedAt,
            note: Value(step.note),
            amountBdt: Value(step.amountBdt),
          ),
        );
  }

  static DefaultEnforcementStep _mapRow(DefaultEnforcementStepRow row) {
    return DefaultEnforcementStep(
      id: row.id,
      shomitiId: row.shomitiId,
      memberId: row.memberId,
      episodeKey: row.episodeKey,
      type: DefaultEnforcementStepType.values.byName(row.stepType),
      recordedAt: row.recordedAt,
      ruleSetVersionId: row.ruleSetVersionId,
      note: row.note,
      amountBdt: row.amountBdt,
    );
  }
}

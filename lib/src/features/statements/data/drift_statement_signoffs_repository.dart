import 'package:drift/drift.dart';

import '../../../core/data/local/app_database.dart';
import '../../contributions/domain/value_objects/billing_month.dart';
import '../domain/entities/statement_signer_role.dart';
import '../domain/entities/statement_signoff.dart';
import '../domain/repositories/statement_signoffs_repository.dart';

class DriftStatementSignoffsRepository implements StatementSignoffsRepository {
  DriftStatementSignoffsRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<List<StatementSignoff>> watchForMonth({
    required String shomitiId,
    required BillingMonth month,
  }) {
    final query = _db.select(_db.statementSignoffs)
      ..where((t) => t.shomitiId.equals(shomitiId) & t.monthKey.equals(month.key))
      ..orderBy([(t) => OrderingTerm(expression: t.signedAt, mode: OrderingMode.desc)]);
    return query.watch().map((rows) => rows.map(_mapRow).toList(growable: false));
  }

  @override
  Future<List<StatementSignoff>> listForMonth({
    required String shomitiId,
    required BillingMonth month,
  }) async {
    final rows =
        await (_db.select(_db.statementSignoffs)
              ..where(
                (t) =>
                    t.shomitiId.equals(shomitiId) & t.monthKey.equals(month.key),
              ))
            .get();
    return rows.map(_mapRow).toList(growable: false);
  }

  @override
  Future<void> upsert(StatementSignoff signoff) async {
    await _db.into(_db.statementSignoffs).insertOnConflictUpdate(
          StatementSignoffsCompanion.insert(
            shomitiId: signoff.shomitiId,
            monthKey: signoff.month.key,
            signerMemberId: signoff.signerMemberId,
            signerRole: signoff.role.name,
            proofReference: signoff.proofReference,
            note: Value(signoff.note),
            signedAt: signoff.signedAt,
            createdAt: signoff.createdAt,
          ),
        );
  }

  @override
  Future<void> delete({
    required String shomitiId,
    required BillingMonth month,
    required String signerMemberId,
  }) async {
    await (_db.delete(_db.statementSignoffs)
          ..where(
            (t) =>
                t.shomitiId.equals(shomitiId) &
                t.monthKey.equals(month.key) &
                t.signerMemberId.equals(signerMemberId),
          ))
        .go();
  }

  static StatementSignoff _mapRow(StatementSignoffRow row) {
    final role = StatementSignerRole.values.firstWhere(
      (r) => r.name == row.signerRole,
      orElse: () => StatementSignerRole.witness,
    );

    return StatementSignoff(
      shomitiId: row.shomitiId,
      month: BillingMonth.fromKey(row.monthKey),
      signerMemberId: row.signerMemberId,
      role: role,
      proofReference: row.proofReference,
      note: row.note,
      signedAt: row.signedAt,
      createdAt: row.createdAt,
    );
  }
}


import 'app_database.dart';

class ResetAppData {
  const ResetAppData(this._db);

  final AppDatabase _db;

  Future<void> call() async {
    await _db.transaction(() async {
      await _db.delete(_db.auditEvents).go();
      await _db.delete(_db.ledgerEntries).go();
      await _db.delete(_db.memberConsents).go();
      await _db.delete(_db.roleAssignments).go();
      await _db.delete(_db.members).go();
      await _db.delete(_db.ruleSetVersions).go();
      await _db.delete(_db.shomitis).go();
    });
  }
}

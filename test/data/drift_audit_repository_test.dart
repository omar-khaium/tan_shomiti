import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/data/local/app_database.dart';
import 'package:tan_shomiti/src/features/audit/data/drift_audit_repository.dart';
import 'package:tan_shomiti/src/features/audit/domain/entities/audit_event.dart';

void main() {
  test('DriftAuditRepository appends and orders newest first', () async {
    final db = AppDatabase.memory();
    addTearDown(db.close);

    final repo = DriftAuditRepository(db);

    await repo.append(
      NewAuditEvent(
        action: 'created_shomiti',
        occurredAt: DateTime.utc(2026, 1, 1, 10),
        message: 'Created a new shomiti',
      ),
    );
    await repo.append(
      NewAuditEvent(
        action: 'recorded_payment',
        occurredAt: DateTime.utc(2026, 1, 2, 10),
        message: 'Recorded payment',
      ),
    );

    final events = await repo.watchLatest().first;
    expect(events, hasLength(2));
    expect(events.first.action, 'recorded_payment');
    expect(events.last.action, 'created_shomiti');
  });
}


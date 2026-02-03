import 'package:drift/drift.dart';

@DataClassName('AuditEventRow')
class AuditEvents extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// A short verb-like label, e.g. "created_shomiti", "recorded_payment".
  TextColumn get action => text()();

  /// Optional free-text details (not PII).
  TextColumn get message => text().nullable()();

  /// Who performed the action (role / member id), if known.
  TextColumn get actor => text().nullable()();

  DateTimeColumn get occurredAt => dateTime()();

  /// Optional JSON blob for non-sensitive metadata (debug/diagnostics).
  TextColumn get metadataJson => text().nullable()();
}


import 'package:drift/drift.dart';

import 'disputes.dart';
import 'shomitis.dart';

@DataClassName('DisputeStepCompletionRow')
class DisputeStepCompletions extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get shomitiId => text().references(Shomitis, #id)();
  TextColumn get disputeId => text().references(Disputes, #id)();

  /// private_discussion | meeting_discussion | mediation | final_outcome
  TextColumn get stepType => text()();

  TextColumn get note => text()();
  TextColumn get proofReference => text().nullable()();

  DateTimeColumn get completedAt => dateTime()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {shomitiId, disputeId, stepType},
  ];
}


import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_database.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  const isFlutterTest = bool.fromEnvironment('FLUTTER_TEST');
  const patrolWait = String.fromEnvironment('PATROL_WAIT', defaultValue: '');
  final isPatrolRun = patrolWait.isNotEmpty;
  final env = Platform.environment;
  final isTestRun =
      isFlutterTest ||
      isPatrolRun ||
      env.containsKey('FLUTTER_TEST') ||
      env.containsKey('XCTestConfigurationFilePath');
  final db = isTestRun ? AppDatabase.memory() : AppDatabase.open();
  ref.onDispose(db.close);
  return db;
});

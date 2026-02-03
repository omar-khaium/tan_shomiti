import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_database.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final env = Platform.environment;
  final isTestRun = env.containsKey('FLUTTER_TEST') ||
      env.containsKey('XCTestConfigurationFilePath');
  final db = isTestRun ? AppDatabase.memory() : AppDatabase.open();
  ref.onDispose(db.close);
  return db;
});

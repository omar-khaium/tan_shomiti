import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_database.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final isFlutterTest = Platform.environment.containsKey('FLUTTER_TEST');
  final db = isFlutterTest ? AppDatabase.memory() : AppDatabase.open();
  ref.onDispose(db.close);
  return db;
});

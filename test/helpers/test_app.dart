import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

Widget createTestApp({
  List<Override> overrides = const [],
}) {
  return ProviderScope(
    overrides: overrides,
    child: const TanShomitiApp(),
  );
}


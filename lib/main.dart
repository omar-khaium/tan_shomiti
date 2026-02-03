import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app/tan_shomiti_app.dart';

void main() {
  runApp(
    const ProviderScope(
      child: TanShomitiApp(),
    ),
  );
}

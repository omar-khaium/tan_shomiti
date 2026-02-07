import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/app/router/app_router.dart';

import 'helpers/test_app.dart';

void main() {
  testWidgets('Dashboard checklist can toggle items (stage2 in-memory)',
      (tester) async {
    await tester.pumpWidget(
      createTestApp(
        overrides: [
          shomitiConfiguredProvider.overrideWith((ref) => true),
        ],
      ),
    );

    expect(find.text('Monthly checklist (Rules §17)'), findsOneWidget);
    expect(find.text('0/6 completed'), findsOneWidget);

    await tester.tap(find.byKey(const Key('ops_check_attendance')));
    await tester.pumpAndSettle();

    expect(find.text('1/6 completed'), findsOneWidget);

    await tester.tap(find.byKey(const Key('ops_month_next')));
    await tester.pumpAndSettle();

    expect(find.text('0/6 completed'), findsOneWidget);
  });
}

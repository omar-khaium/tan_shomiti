import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tan_shomiti/src/core/ui/theme/app_theme.dart';
import 'package:tan_shomiti/src/features/shomiti_setup/presentation/setup_wizard_page.dart';

void main() {
  Future<void> pumpWizard(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.light(),
          home: const SetupWizardPage(),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('Setup wizard validates required fields', (tester) async {
    await pumpWizard(tester);

    expect(find.text('Shomiti basics'), findsOneWidget);

    await tester.tap(find.byKey(const Key('setup_next')));
    await tester.pump();
    expect(find.text('Required'), findsOneWidget);

    await tester.enterText(
      find.byKey(const Key('setup_name_field')),
      'My Shomiti',
    );

    await tester.tap(find.byKey(const Key('setup_next')));
    await tester.pump();

    expect(find.text('Members and shares'), findsOneWidget);
  });

  testWidgets('Setup wizard validates numeric inputs', (tester) async {
    await pumpWizard(tester);

    await tester.enterText(
      find.byKey(const Key('setup_name_field')),
      'My Shomiti',
    );
    await tester.tap(find.byKey(const Key('setup_next')));
    await tester.pump();

    await tester.tap(find.byKey(const Key('setup_next')));
    await tester.pump();

    expect(find.text('Required'), findsNWidgets(2));

    await tester.enterText(
      find.byKey(const Key('setup_member_count_field')),
      '10',
    );
    await tester.enterText(
      find.byKey(const Key('setup_share_value_field')),
      '1000',
    );

    await tester.tap(find.byKey(const Key('setup_next')));
    await tester.pump();

    expect(find.text('Schedule'), findsOneWidget);
  });
}

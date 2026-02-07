import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tan_shomiti/src/features/statements/presentation/components/statement_signoffs_section.dart';

void main() {
  testWidgets('StatementSignoffsSection adds and removes sign-offs', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(body: Padding(padding: EdgeInsets.all(16), child: StatementSignoffsSection())),
        ),
      ),
    );

    expect(find.byKey(const Key('statement_signoff_status')), findsOneWidget);
    expect(find.text('Not signed'), findsOneWidget);
    expect(find.byKey(const Key('statement_signoffs_empty')), findsOneWidget);

    await tester.tap(find.byKey(const Key('statement_add_signoff')));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('statement_signoff_signer_name')),
      'Member 2',
    );
    await tester.pump();
    await tester.enterText(
      find.byKey(const Key('statement_signoff_proof')),
      'chat://proof',
    );
    await tester.pump();
    await tester.tap(find.byKey(const Key('statement_signoff_save')));
    await tester.pumpAndSettle();

    expect(find.text('Partially signed'), findsOneWidget);
    expect(find.byKey(const Key('statement_signoff_name_0')), findsOneWidget);

    await tester.tap(find.byKey(const Key('statement_signoff_remove_0')));
    await tester.pumpAndSettle();

    expect(find.text('Not signed'), findsOneWidget);
    expect(find.byKey(const Key('statement_signoffs_empty')), findsOneWidget);
  });
}

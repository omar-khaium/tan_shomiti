import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tan_shomiti/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('E2E-00: launch app', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // When not configured, app shows Setup placeholder.
    expect(find.text('Setup'), findsWidgets);
  });
}


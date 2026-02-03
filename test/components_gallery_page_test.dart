import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/ui/pages/components_gallery_page.dart';
import 'package:tan_shomiti/src/core/ui/theme/app_theme.dart';

void main() {
  testWidgets('Components gallery renders key sections', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const ComponentsGalleryPage(),
      ),
    );

    expect(find.text('Components'), findsOneWidget);
    expect(find.text('Buttons'), findsOneWidget);
    expect(find.text('Primary'), findsOneWidget);
    expect(find.text('Inputs'), findsOneWidget);
    expect(find.text('Shomiti name'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Status chips'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('Status chips'), findsOneWidget);
    expect(find.text('Paid'), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/ui/components/app_button.dart';
import 'package:tan_shomiti/src/core/ui/components/app_empty_state.dart';
import 'package:tan_shomiti/src/core/ui/components/app_error_state.dart';
import 'package:tan_shomiti/src/core/ui/components/app_text_field.dart';
import 'package:tan_shomiti/src/core/ui/theme/app_theme.dart';

void main() {
  testWidgets('AppButton primary shows label', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: AppButton.primary(
            label: 'Continue',
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(find.text('Continue'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('AppButton primary shows loader when isLoading', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: AppButton.primary(
            label: 'Continue',
            onPressed: () {},
            isLoading: true,
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('AppTextField shows error text', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: AppTextField(
            label: 'Share value (BDT)',
            errorText: 'Invalid amount',
            keyboardType: TextInputType.number,
          ),
        ),
      ),
    );

    expect(find.text('Share value (BDT)'), findsOneWidget);
    expect(find.text('Invalid amount'), findsOneWidget);
  });

  testWidgets('AppEmptyState renders title and message', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: AppEmptyState(
            title: 'No entries yet',
            message: 'Create a Shomiti to get started.',
            icon: Icons.inbox_outlined,
          ),
        ),
      ),
    );

    expect(find.text('No entries yet'), findsOneWidget);
    expect(find.text('Create a Shomiti to get started.'), findsOneWidget);
  });

  testWidgets('AppErrorState shows retry when onRetry is provided', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: AppErrorState(
            message: 'Something went wrong',
            onRetry: () {},
          ),
        ),
      ),
    );

    expect(find.text('Something went wrong'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });
}


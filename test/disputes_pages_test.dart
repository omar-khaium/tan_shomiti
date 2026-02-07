import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/ui/components/app_button.dart';
import 'package:tan_shomiti/src/core/ui/theme/app_theme.dart';
import 'package:tan_shomiti/src/features/disputes/domain/entities/dispute.dart';
import 'package:tan_shomiti/src/features/disputes/domain/entities/dispute_step.dart';
import 'package:tan_shomiti/src/features/disputes/presentation/dispute_detail_page.dart';
import 'package:tan_shomiti/src/features/disputes/presentation/disputes_page.dart';
import 'package:tan_shomiti/src/features/disputes/presentation/providers/disputes_providers.dart';

void main() {
  Future<void> pumpPage(
    WidgetTester tester,
    Widget page, {
    List<Override> overrides = const [],
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: MaterialApp(theme: AppTheme.light(), home: page),
      ),
    );
    await tester.pump();
  }

  testWidgets('Disputes page shows loading state', (tester) async {
    final controller = StreamController<List<Dispute>>();
    await pumpPage(
      tester,
      const DisputesPage(),
      overrides: [
        disputesProvider.overrideWith((ref) => controller.stream),
      ],
    );

    expect(find.text('Loading…'), findsOneWidget);
    await controller.close();
  });

  testWidgets('Disputes page shows empty open state', (tester) async {
    await pumpPage(
      tester,
      const DisputesPage(),
      overrides: [
        disputesProvider.overrideWith((ref) => Stream.value(const [])),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.byKey(const Key('disputes_open_empty')), findsOneWidget);
  });

  testWidgets('Disputes page shows error state when provider throws', (
    tester,
  ) async {
    await pumpPage(
      tester,
      const DisputesPage(),
      overrides: [
        disputesProvider.overrideWith(
          (ref) => Stream<List<Dispute>>.error(Exception('boom')),
        ),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.text('Failed to load disputes.'), findsOneWidget);
  });

  testWidgets('Dispute detail disables step 2 before step 1 completion', (
    tester,
  ) async {
    const id = 'dsp_test';
    final now = DateTime.utc(2026, 2, 7, 12);
    final dispute = Dispute(
      id: id,
      shomitiId: 'active',
      title: 'Test dispute',
      description: 'Neutral description.',
      createdAt: now,
      status: DisputeStatus.open,
      steps: const [
        DisputeStepRecord(
          step: DisputeStep.privateDiscussion,
          note: null,
          proofReference: null,
          completedAt: null,
        ),
        DisputeStepRecord(
          step: DisputeStep.meetingDiscussion,
          note: null,
          proofReference: null,
          completedAt: null,
        ),
        DisputeStepRecord(
          step: DisputeStep.mediation,
          note: null,
          proofReference: null,
          completedAt: null,
        ),
        DisputeStepRecord(
          step: DisputeStep.finalOutcome,
          note: null,
          proofReference: null,
          completedAt: null,
        ),
      ],
      relatedMonthKey: null,
      involvedMembersText: null,
      evidenceReferences: const [],
      resolvedAt: null,
    );

    await pumpPage(
      tester,
      const DisputeDetailPage(disputeId: id),
      overrides: [
        disputeByIdProvider.overrideWith((ref, disputeId) async => dispute),
      ],
    );

    await tester.pumpAndSettle();
    final button = tester.widget<AppButton>(
      find.byKey(const Key('dispute_step_complete_meetingDiscussion')),
    );
    expect(button.onPressed, isNull);
  });
}

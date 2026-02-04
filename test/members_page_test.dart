import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/ui/theme/app_theme.dart';
import 'package:tan_shomiti/src/features/members/domain/entities/member.dart';
import 'package:tan_shomiti/src/features/members/presentation/models/members_ui_state.dart';
import 'package:tan_shomiti/src/features/members/presentation/members_page.dart';
import 'package:tan_shomiti/src/features/members/presentation/providers/members_providers.dart';

void main() {
  Future<void> pumpPage(
    WidgetTester tester, {
    List<Override> overrides = const [],
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: MaterialApp(theme: AppTheme.light(), home: const MembersPage()),
      ),
    );
    await tester.pump();
  }

  testWidgets('Members page shows loading state', (tester) async {
    final controller = StreamController<MembersUiState?>();
    addTearDown(controller.close);

    await pumpPage(
      tester,
      overrides: [
        membersUiStateProvider.overrideWith((ref) => controller.stream),
      ],
    );

    expect(find.text('Loading…'), findsOneWidget);
  });

  testWidgets('Members page shows error state', (tester) async {
    await pumpPage(
      tester,
      overrides: [
        membersUiStateProvider.overrideWith(
          (ref) => Stream<MembersUiState?>.error(Exception('boom')),
        ),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.text('Failed to load members.'), findsOneWidget);
  });

  testWidgets('Members page shows empty state', (tester) async {
    await pumpPage(
      tester,
      overrides: [
        membersUiStateProvider.overrideWith(
          (ref) => Stream.value(
            const MembersUiState(
              shomitiId: 'active',
              isJoiningClosed: false,
              closedJoiningReason: null,
              members: [],
            ),
          ),
        ),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.text('No members yet'), findsOneWidget);
    expect(find.byKey(const Key('members_add')), findsOneWidget);
  });

  testWidgets('Members page disables add when joining is closed', (
    tester,
  ) async {
    await pumpPage(
      tester,
      overrides: [
        membersUiStateProvider.overrideWith(
          (ref) => Stream.value(
            const MembersUiState(
              shomitiId: 'active',
              isJoiningClosed: true,
              closedJoiningReason: 'Joining is closed.',
              members: [],
            ),
          ),
        ),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.text('Joining is closed.'), findsOneWidget);
    final fab = tester.widget<FloatingActionButton>(
      find.byKey(const Key('members_add')),
    );
    expect(fab.onPressed, isNull);
  });

  testWidgets('Members page shows member rows', (tester) async {
    final member = Member(
      id: 'm1',
      shomitiId: 'active',
      position: 1,
      fullName: 'Alice',
      phone: '01700000000',
      addressOrWorkplace: 'Dhaka',
      emergencyContactName: 'Bob',
      emergencyContactPhone: '01800000000',
      nidOrPassport: null,
      notes: null,
      isActive: true,
      createdAt: DateTime(2026, 1, 1),
      updatedAt: null,
    );

    await pumpPage(
      tester,
      overrides: [
        membersUiStateProvider.overrideWith(
          (ref) => Stream.value(
            MembersUiState(
              shomitiId: 'active',
              isJoiningClosed: false,
              closedJoiningReason: null,
              members: [member],
            ),
          ),
        ),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.byKey(const Key('member_row_m1')), findsOneWidget);
    expect(find.text('Alice'), findsOneWidget);
  });
}

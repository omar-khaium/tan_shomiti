import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/ui/theme/app_theme.dart';
import 'package:tan_shomiti/src/features/members/presentation/members_page.dart';
import 'package:tan_shomiti/src/features/members/presentation/providers/members_demo_providers.dart';

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
    await pumpPage(
      tester,
      overrides: [
        membersDemoControllerProvider.overrideWith(
          _LoadingMembersDemoController.new,
        ),
      ],
    );

    expect(find.text('Loading…'), findsOneWidget);
  });

  testWidgets('Members page shows error state', (tester) async {
    await pumpPage(
      tester,
      overrides: [
        membersDemoControllerProvider.overrideWith(
          _ThrowingMembersDemoController.new,
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
        membersDemoControllerProvider.overrideWith(
          () => _DataMembersDemoController(
            const MembersDemoState(
              members: [],
              isJoiningClosed: false,
              closedJoiningReason: null,
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
        membersDemoControllerProvider.overrideWith(
          () => _DataMembersDemoController(
            const MembersDemoState(
              members: [],
              isJoiningClosed: true,
              closedJoiningReason: 'Joining is closed.',
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
    final member = MembersDemoMember(
      id: 'm1',
      fullName: 'Alice',
      phone: '01700000000',
      addressOrWorkplace: 'Dhaka',
      emergencyContactName: 'Bob',
      emergencyContactPhone: '01800000000',
      nidOrPassport: null,
      notes: null,
      isActive: true,
      createdAt: DateTime(2026, 1, 1),
    );

    await pumpPage(
      tester,
      overrides: [
        membersDemoControllerProvider.overrideWith(
          () => _DataMembersDemoController(
            MembersDemoState(
              members: [member],
              isJoiningClosed: false,
              closedJoiningReason: null,
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

class _LoadingMembersDemoController extends MembersDemoController {
  final _completer = Completer<MembersDemoState>();

  @override
  Future<MembersDemoState> build() => _completer.future;
}

class _ThrowingMembersDemoController extends MembersDemoController {
  @override
  Future<MembersDemoState> build() async {
    throw Exception('boom');
  }
}

class _DataMembersDemoController extends MembersDemoController {
  _DataMembersDemoController(this._state);

  final MembersDemoState _state;

  @override
  MembersDemoState build() => _state;
}

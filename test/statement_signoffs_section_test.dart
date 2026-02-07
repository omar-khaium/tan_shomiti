import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/features/contributions/domain/value_objects/billing_month.dart';
import 'package:tan_shomiti/src/features/members/domain/entities/member.dart';
import 'package:tan_shomiti/src/features/members/presentation/models/members_ui_state.dart';
import 'package:tan_shomiti/src/features/members/presentation/providers/members_providers.dart';
import 'package:tan_shomiti/src/features/statements/domain/entities/statement_signoff.dart';
import 'package:tan_shomiti/src/features/statements/domain/repositories/statement_signoffs_repository.dart';
import 'package:tan_shomiti/src/features/statements/presentation/components/statement_signoffs_section.dart';
import 'package:tan_shomiti/src/features/statements/presentation/providers/statements_domain_providers.dart';

void main() {
  testWidgets('Statement sign-off section renders and enables dialog save', (
    tester,
  ) async {
    final args = StatementMonthArgs(
      shomitiId: 's1',
      month: BillingMonth.fromKey('2026-02'),
    );

    final fakeRepo = _FakeStatementSignoffsRepository();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          statementSignoffsRepositoryProvider.overrideWithValue(fakeRepo),
          membersUiStateProvider.overrideWith(
            (ref) => Stream.value(
              MembersUiState(
                shomitiId: 's1',
                isJoiningClosed: false,
                closedJoiningReason: null,
                members: [
                  Member(
                    id: 'm1',
                    shomitiId: 's1',
                    position: 1,
                    fullName: 'Member 1',
                    phone: null,
                    addressOrWorkplace: null,
                    nidOrPassport: null,
                    emergencyContactName: null,
                    emergencyContactPhone: null,
                    notes: null,
                    isActive: true,
                    createdAt: DateTime(2026, 1, 1),
                    updatedAt: null,
                  ),
                  Member(
                    id: 'm2',
                    shomitiId: 's1',
                    position: 2,
                    fullName: 'Member 2',
                    phone: null,
                    addressOrWorkplace: null,
                    nidOrPassport: null,
                    emergencyContactName: null,
                    emergencyContactPhone: null,
                    notes: null,
                    isActive: true,
                    createdAt: DateTime(2026, 1, 1),
                    updatedAt: null,
                  ),
                ],
              ),
            ),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: StatementSignoffsSection(args: args, isEnabled: true),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('statement_signoff_status')), findsOneWidget);
    expect(find.text('Not signed'), findsOneWidget);
    expect(find.byKey(const Key('statement_signoffs_empty')), findsOneWidget);

    await tester.tap(find.byKey(const Key('statement_add_signoff')));
    await tester.pumpAndSettle();

    // Save disabled initially.
    final saveButton = tester.widget<FilledButton>(
      find.byKey(const Key('statement_signoff_save')),
    );
    expect(saveButton.onPressed, isNull);

    await tester.tap(find.byKey(const Key('statement_signoff_signer_member')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Member 2').last);
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('statement_signoff_proof')),
      'chat://proof',
    );
    await tester.pump();

    final saveEnabledButton = tester.widget<FilledButton>(
      find.byKey(const Key('statement_signoff_save')),
    );
    expect(saveEnabledButton.onPressed, isNotNull);
  });
}

class _FakeStatementSignoffsRepository implements StatementSignoffsRepository {
  _FakeStatementSignoffsRepository();

  final _controller = StreamController<List<StatementSignoff>>.broadcast()
    ..add(const []);

  @override
  Stream<List<StatementSignoff>> watchForMonth({
    required String shomitiId,
    required BillingMonth month,
  }) {
    return _controller.stream;
  }

  @override
  Future<List<StatementSignoff>> listForMonth({
    required String shomitiId,
    required BillingMonth month,
  }) async {
    return const [];
  }

  @override
  Future<void> upsert(StatementSignoff signoff) async {}

  @override
  Future<void> delete({
    required String shomitiId,
    required BillingMonth month,
    required String signerMemberId,
  }) async {}
}

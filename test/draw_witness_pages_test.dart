import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/ui/components/app_button.dart';
import 'package:tan_shomiti/src/core/ui/theme/app_theme.dart';
import 'package:tan_shomiti/src/features/contributions/domain/value_objects/billing_month.dart';
import 'package:tan_shomiti/src/features/draw/domain/entities/draw_record.dart';
import 'package:tan_shomiti/src/features/draw/domain/entities/draw_witness_approval.dart';
import 'package:tan_shomiti/src/features/draw/presentation/draw_record_details_page.dart';
import 'package:tan_shomiti/src/features/draw/presentation/redo_draw_page.dart';
import 'package:tan_shomiti/src/features/draw/presentation/witness_signoff_page.dart';
import 'package:tan_shomiti/src/features/draw/presentation/models/draw_record_details_ui_state.dart';
import 'package:tan_shomiti/src/features/draw/presentation/providers/draw_providers.dart';
import 'package:tan_shomiti/src/features/draw/domain/value_objects/draw_method.dart';
import 'package:tan_shomiti/src/features/members/domain/entities/member.dart';

void main() {
  testWidgets('Draw record details page renders required keys', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          drawRecordDetailsUiProvider.overrideWith(
            (ref) => AsyncValue.data(
              const DrawRecordDetailsUiState(
                month: BillingMonth(year: 2026, month: 2),
                hasRecord: true,
                drawId: 'draw_1',
                methodLabel: 'Numbered tokens',
                proofReference: 'vid-123',
                winnerLabel: 'Member 1 (share 1)',
                statusLabel: 'Pending witness sign-off',
                witnessCount: 0,
              ),
            ),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          home: const DrawRecordDetailsPage(),
        ),
      ),
    );

    expect(find.byKey(const Key('draw_record_month_label')), findsOneWidget);
    expect(find.byKey(const Key('draw_record_method')), findsOneWidget);
    expect(find.byKey(const Key('draw_record_proof_ref')), findsOneWidget);
    expect(find.byKey(const Key('draw_record_winner')), findsOneWidget);
    expect(find.byKey(const Key('draw_record_status')), findsOneWidget);
    expect(find.byKey(const Key('draw_collect_witnesses')), findsOneWidget);
    expect(find.byKey(const Key('draw_redo')), findsOneWidget);
  });

  testWidgets('Witness sign-off enables finalize after two approvals', (
    tester,
  ) async {
    final now = DateTime.utc(2026, 2, 5, 10);
    const month = BillingMonth(year: 2026, month: 2);
    const drawId = 'draw_1';

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          drawRecordByIdProvider.overrideWith((ref, id) async {
            return DrawRecord(
              id: drawId,
              shomitiId: 'active',
              month: month,
              ruleSetVersionId: 'rsv_1',
              method: DrawMethod.numberedTokens,
              proofReference: 'vid-001',
              notes: null,
              winnerMemberId: 'm1',
              winnerShareIndex: 1,
              eligibleShareKeys: const ['m1#1'],
              redoOfDrawId: null,
              invalidatedAt: null,
              invalidatedReason: null,
              finalizedAt: null,
              recordedAt: now,
            );
          }),
          membersForDrawProvider.overrideWith((ref, id) async {
            return [
              Member(
                id: 'm1',
                shomitiId: 'active',
                position: 1,
                fullName: 'Member 1',
                phone: null,
                addressOrWorkplace: null,
                emergencyContactName: null,
                emergencyContactPhone: null,
                nidOrPassport: null,
                notes: null,
                isActive: true,
                createdAt: now,
                updatedAt: null,
              ),
              Member(
                id: 'm2',
                shomitiId: 'active',
                position: 2,
                fullName: 'Member 2',
                phone: null,
                addressOrWorkplace: null,
                emergencyContactName: null,
                emergencyContactPhone: null,
                nidOrPassport: null,
                notes: null,
                isActive: true,
                createdAt: now,
                updatedAt: null,
              ),
              Member(
                id: 'm3',
                shomitiId: 'active',
                position: 3,
                fullName: 'Member 3',
                phone: null,
                addressOrWorkplace: null,
                emergencyContactName: null,
                emergencyContactPhone: null,
                nidOrPassport: null,
                notes: null,
                isActive: true,
                createdAt: now,
                updatedAt: null,
              ),
            ];
          }),
          drawWitnessApprovalsProvider.overrideWith((ref, id) {
            return Stream.value(
              [
                DrawWitnessApproval(
                  drawId: drawId,
                  witnessMemberId: 'm2',
                  ruleSetVersionId: 'rsv_1',
                  note: null,
                  approvedAt: now,
                ),
                DrawWitnessApproval(
                  drawId: drawId,
                  witnessMemberId: 'm3',
                  ruleSetVersionId: 'rsv_1',
                  note: null,
                  approvedAt: now.add(const Duration(minutes: 1)),
                ),
              ],
            );
          }),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          home: const WitnessSignoffPage(drawId: drawId),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('witness_count_label')), findsOneWidget);
    final finalizeFinder = find.byKey(const Key('witness_finalize'));
    final button = tester.widget<AppButton>(finalizeFinder);
    expect(button.onPressed, isNotNull);
  });

  testWidgets('Redo draw requires reason to enable confirm', (tester) async {
    final now = DateTime.utc(2026, 2, 5, 10);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          drawRecordByIdProvider.overrideWith((ref, id) async {
            return DrawRecord(
              id: 'draw_1',
              shomitiId: 'active',
              month: const BillingMonth(year: 2026, month: 2),
              ruleSetVersionId: 'rsv_1',
              method: DrawMethod.numberedTokens,
              proofReference: 'vid-001',
              notes: null,
              winnerMemberId: 'm1',
              winnerShareIndex: 1,
              eligibleShareKeys: const ['m1#1'],
              redoOfDrawId: null,
              invalidatedAt: null,
              invalidatedReason: null,
              finalizedAt: null,
              recordedAt: now,
            );
          }),
        ],
        child: MaterialApp(theme: AppTheme.light(), home: const RedoDrawPage(drawId: 'draw_1')),
      ),
    );
    await tester.pumpAndSettle();

    final confirmFinder = find.byKey(const Key('redo_confirm'));
    final button0 = tester.widget<AppButton>(confirmFinder);
    expect(button0.onPressed, isNull);

    await tester.enterText(find.byKey(const Key('redo_reason')), 'Slip fell out');
    await tester.pumpAndSettle();

    final button1 = tester.widget<AppButton>(confirmFinder);
    expect(button1.onPressed, isNotNull);
  });
}

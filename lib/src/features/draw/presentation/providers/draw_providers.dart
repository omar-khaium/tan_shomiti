import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/draw_controller.dart';
import '../controllers/draw_record_details_controller.dart';
import '../../../members/domain/entities/member.dart';
import '../../domain/entities/draw_record.dart';
import '../../domain/entities/draw_witness_approval.dart';
import '../models/draw_ui_state.dart';
import '../models/draw_record_details_ui_state.dart';
import 'draw_domain_providers.dart';
import '../../../members/presentation/providers/members_providers.dart';

final drawControllerProvider =
    AsyncNotifierProvider.autoDispose<DrawController, DrawUiState>(
      DrawController.new,
    );

final drawUiStateProvider = Provider.autoDispose<AsyncValue<DrawUiState>>(
  (ref) => ref.watch(drawControllerProvider),
);

final drawRecordDetailsControllerProvider =
    AsyncNotifierProvider.autoDispose<DrawRecordDetailsController, DrawRecordDetailsUiState?>(
      DrawRecordDetailsController.new,
    );

final drawRecordDetailsUiProvider =
    Provider.autoDispose<AsyncValue<DrawRecordDetailsUiState?>>(
      (ref) => ref.watch(drawRecordDetailsControllerProvider),
    );

final drawRecordByIdProvider =
    FutureProvider.autoDispose.family<DrawRecord?, String>((ref, id) async {
      return ref.watch(drawRecordsRepositoryProvider).getById(id: id);
    });

final drawWitnessApprovalsProvider =
    StreamProvider.autoDispose.family<List<DrawWitnessApproval>, String>((
  ref,
  drawId,
) {
  return ref.watch(drawWitnessRepositoryProvider).watchApprovals(drawId: drawId);
});

final membersForDrawProvider =
    FutureProvider.autoDispose.family<List<Member>, String>((ref, drawId) async {
      final draw = await ref.watch(drawRecordByIdProvider(drawId).future);
      if (draw == null) return const [];
      return ref.watch(membersRepositoryProvider).listMembers(
            shomitiId: draw.shomitiId,
          );
    });

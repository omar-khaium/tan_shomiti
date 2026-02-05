import '../entities/draw_witness_approval.dart';

abstract class DrawWitnessRepository {
  Stream<List<DrawWitnessApproval>> watchApprovals({
    required String drawId,
  });

  Future<List<DrawWitnessApproval>> listApprovals({
    required String drawId,
  });

  Future<void> upsertApproval(DrawWitnessApproval approval);
}


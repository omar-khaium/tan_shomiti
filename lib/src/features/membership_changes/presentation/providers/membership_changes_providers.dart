import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/membership_changes_controller.dart';
import '../models/membership_change_ui_models.dart';

final membershipChangesControllerProvider =
    AsyncNotifierProvider.autoDispose<
      MembershipChangesController,
      MembershipChangesUiState?
    >(MembershipChangesController.new);

final membershipChangesUiStateProvider =
    Provider.autoDispose<AsyncValue<MembershipChangesUiState?>>(
      (ref) => ref.watch(membershipChangesControllerProvider),
    );

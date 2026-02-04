import 'package:flutter/foundation.dart';

import '../../domain/entities/member.dart';

@immutable
class MembersUiState {
  const MembersUiState({
    required this.shomitiId,
    required this.isJoiningClosed,
    required this.closedJoiningReason,
    required this.members,
  });

  final String shomitiId;
  final bool isJoiningClosed;
  final String? closedJoiningReason;
  final List<Member> members;
}

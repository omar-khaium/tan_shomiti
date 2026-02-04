import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final membersDemoControllerProvider =
    AutoDisposeAsyncNotifierProvider<MembersDemoController, MembersDemoState>(
      MembersDemoController.new,
    );

class MembersDemoController extends AutoDisposeAsyncNotifier<MembersDemoState> {
  @override
  FutureOr<MembersDemoState> build() {
    return const MembersDemoState(
      members: [],
      isJoiningClosed: false,
      closedJoiningReason: null,
    );
  }

  MembersDemoMember? findById(String id) {
    final current = state.valueOrNull;
    if (current == null) return null;

    for (final member in current.members) {
      if (member.id == id) return member;
    }
    return null;
  }

  Future<void> upsertMember(MembersDemoMember member) async {
    final current = state.valueOrNull;
    if (current == null) return;

    final members = [...current.members];
    final index = members.indexWhere((m) => m.id == member.id);
    if (index == -1) {
      members.add(member);
    } else {
      members[index] = member;
    }

    state = AsyncData(current.copyWith(members: members));
  }

  Future<void> deactivateMember(String memberId) async {
    final current = state.valueOrNull;
    if (current == null) return;

    final members = current.members
        .map(
          (member) =>
              member.id == memberId ? member.copyWith(isActive: false) : member,
        )
        .toList(growable: false);

    state = AsyncData(current.copyWith(members: members));
  }

  String newMemberId() {
    final now = DateTime.now().microsecondsSinceEpoch.toRadixString(36);
    final rand = Random.secure().nextInt(1 << 32).toRadixString(36);
    return 'm_${now}_$rand';
  }
}

@immutable
class MembersDemoState {
  const MembersDemoState({
    required this.members,
    required this.isJoiningClosed,
    required this.closedJoiningReason,
  });

  final List<MembersDemoMember> members;
  final bool isJoiningClosed;
  final String? closedJoiningReason;

  MembersDemoState copyWith({
    List<MembersDemoMember>? members,
    bool? isJoiningClosed,
    String? closedJoiningReason,
  }) {
    return MembersDemoState(
      members: members ?? this.members,
      isJoiningClosed: isJoiningClosed ?? this.isJoiningClosed,
      closedJoiningReason: closedJoiningReason ?? this.closedJoiningReason,
    );
  }
}

@immutable
class MembersDemoMember {
  const MembersDemoMember({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.addressOrWorkplace,
    required this.emergencyContactName,
    required this.emergencyContactPhone,
    required this.nidOrPassport,
    required this.notes,
    required this.isActive,
    required this.createdAt,
  });

  final String id;
  final String fullName;
  final String phone;
  final String addressOrWorkplace;
  final String emergencyContactName;
  final String emergencyContactPhone;
  final String? nidOrPassport;
  final String? notes;
  final bool isActive;
  final DateTime createdAt;

  bool get isProfileComplete =>
      fullName.trim().isNotEmpty &&
      phone.trim().isNotEmpty &&
      addressOrWorkplace.trim().isNotEmpty &&
      emergencyContactName.trim().isNotEmpty &&
      emergencyContactPhone.trim().isNotEmpty;

  MembersDemoMember copyWith({
    String? fullName,
    String? phone,
    String? addressOrWorkplace,
    String? emergencyContactName,
    String? emergencyContactPhone,
    String? nidOrPassport,
    String? notes,
    bool? isActive,
  }) {
    return MembersDemoMember(
      id: id,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      addressOrWorkplace: addressOrWorkplace ?? this.addressOrWorkplace,
      emergencyContactName: emergencyContactName ?? this.emergencyContactName,
      emergencyContactPhone:
          emergencyContactPhone ?? this.emergencyContactPhone,
      nidOrPassport: nidOrPassport ?? this.nidOrPassport,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt,
    );
  }
}

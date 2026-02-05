import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/collection_resolution.dart';
import '../../domain/value_objects/billing_month.dart';
import 'contributions_domain_providers.dart';

@immutable
class CollectionResolutionArgs {
  const CollectionResolutionArgs({
    required this.shomitiId,
    required this.month,
  });

  final String shomitiId;
  final BillingMonth month;

  @override
  bool operator ==(Object other) {
    return other is CollectionResolutionArgs &&
        other.shomitiId == shomitiId &&
        other.month == month;
  }

  @override
  int get hashCode => Object.hash(shomitiId, month);
}

final collectionResolutionProvider = StreamProvider.autoDispose
    .family<CollectionResolution?, CollectionResolutionArgs>((ref, args) {
  return ref.watch(monthlyCollectionRepositoryProvider).watchResolution(
        shomitiId: args.shomitiId,
        month: args.month,
      );
});


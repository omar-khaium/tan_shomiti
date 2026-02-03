import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ui/components/app_empty_state.dart';
import '../../../core/ui/components/app_error_state.dart';
import '../../../core/ui/components/app_list_row.dart';
import '../../../core/ui/components/app_loading_state.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import '../domain/entities/audit_event.dart';
import 'providers/audit_providers.dart';

class AuditLogPage extends ConsumerWidget {
  const AuditLogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(auditLogProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Audit log')),
      floatingActionButton: kDebugMode
          ? FloatingActionButton(
              key: const Key('audit_add_demo_event'),
              onPressed: () async {
                await ref.read(appendAuditEventProvider)(
                      NewAuditEvent(
                        action: 'demo_event',
                        occurredAt: DateTime.now().toUtc(),
                        message: 'Demo audit event (debug only).',
                      ),
                    );
              },
              child: const Icon(Icons.add),
            )
          : null,
      body: events.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(AppSpacing.s16),
          child: AppLoadingState(),
        ),
        error: (error, stack) => const Padding(
          padding: EdgeInsets.all(AppSpacing.s16),
          child: AppErrorState(
            message: 'Failed to load audit log.',
          ),
        ),
        data: (items) {
          if (items.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.s16),
              child: AppEmptyState(
                title: 'No audit events yet',
                message:
                    'Actions and approvals will appear here for transparency.',
                icon: Icons.receipt_long_outlined,
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.s16),
            itemCount: items.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final event = items[index];
              final formattedDate =
                  MaterialLocalizations.of(context).formatShortDate(
                event.occurredAt,
              );

              return AppListRow(
                title: event.action,
                value: event.message ?? formattedDate,
              );
            },
          );
        },
      ),
    );
  }
}

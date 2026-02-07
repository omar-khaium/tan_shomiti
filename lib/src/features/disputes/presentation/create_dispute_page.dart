import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_router.dart';
import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/components/app_text_field.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import '../../../features/shomiti_setup/presentation/providers/shomiti_setup_providers.dart';
import 'providers/disputes_providers.dart';

class CreateDisputePage extends ConsumerStatefulWidget {
  const CreateDisputePage({super.key});

  @override
  ConsumerState<CreateDisputePage> createState() => _CreateDisputePageState();
}

class _CreateDisputePageState extends ConsumerState<CreateDisputePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _relatedMonthController = TextEditingController();
  final _involvedMembersController = TextEditingController();
  final _evidenceController = TextEditingController();

  bool _saving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _relatedMonthController.dispose();
    _involvedMembersController.dispose();
    _evidenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create dispute')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppCard(
                child: Text(
                  'Use neutral, factual language. Avoid sensitive personal info. Evidence should be references (links/ids), not uploads (MVP).',
                  key: Key('create_dispute_guidance'),
                ),
              ),
              const SizedBox(height: AppSpacing.s16),
              AppTextField(
                fieldKey: const Key('create_dispute_title'),
                label: 'Title',
                controller: _titleController,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Title is required.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.s12),
              TextFormField(
                key: const Key('create_dispute_description'),
                controller: _descriptionController,
                textInputAction: TextInputAction.newline,
                minLines: 3,
                maxLines: 8,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  helperText: 'What happened (briefly, factual, no shaming).',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Description is required.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.s12),
              AppTextField(
                fieldKey: const Key('create_dispute_related_month'),
                label: 'Related month (optional)',
                hint: 'e.g., 2026-02',
                controller: _relatedMonthController,
              ),
              const SizedBox(height: AppSpacing.s12),
              AppTextField(
                fieldKey: const Key('create_dispute_involved_members'),
                label: 'Involved members (optional)',
                hint: 'Names or ids (keep minimal)',
                controller: _involvedMembersController,
              ),
              const SizedBox(height: AppSpacing.s12),
              TextFormField(
                key: const Key('create_dispute_evidence'),
                controller: _evidenceController,
                minLines: 2,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: 'Evidence references (optional)',
                  helperText: 'One per line (link, message id, receipt ref).',
                ),
              ),
              const SizedBox(height: AppSpacing.s24),
              Row(
                children: [
                  Expanded(
                    child: AppButton.secondary(
                      key: const Key('create_dispute_cancel'),
                      label: 'Cancel',
                      onPressed: _saving ? null : () => context.pop(),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.s12),
                  Expanded(
                    child: AppButton.primary(
                      key: const Key('create_dispute_submit'),
                      label: _saving ? 'Saving…' : 'Create',
                      onPressed: _saving ? null : _create,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _create() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);

    try {
      final shomiti = await ref.read(activeShomitiProvider.future);
      if (shomiti == null) {
        throw StateError('Shomiti is not configured.');
      }

      final id = await ref.read(disputesRepositoryProvider).createDispute(
            shomitiId: shomiti.id,
            title: _titleController.text,
            description: _descriptionController.text,
            relatedMonthKey: _relatedMonthController.text.trim().isEmpty
                ? null
                : _relatedMonthController.text.trim(),
            involvedMembersText: _involvedMembersController.text.trim().isEmpty
                ? null
                : _involvedMembersController.text.trim(),
            evidenceReferences: _evidenceController.text.split('\n'),
            now: DateTime.now(),
          );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dispute created.')),
      );
      context.go(disputeDetailsLocation(id));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create: $e')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}

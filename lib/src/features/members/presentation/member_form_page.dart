import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_empty_state.dart';
import '../../../core/ui/components/app_error_state.dart';
import '../../../core/ui/components/app_loading_state.dart';
import '../../../core/ui/components/app_text_field.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import '../domain/entities/member.dart';
import '../domain/entities/member_profile_input.dart';
import '../domain/usecases/member_write_exceptions.dart';
import 'providers/members_providers.dart';

class MemberFormPage extends ConsumerStatefulWidget {
  const MemberFormPage({required this.mode, this.memberId, super.key});

  final MemberFormMode mode;
  final String? memberId;

  @override
  ConsumerState<MemberFormPage> createState() => _MemberFormPageState();
}

class _MemberFormPageState extends ConsumerState<MemberFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _nidController = TextEditingController();
  final _emergencyNameController = TextEditingController();
  final _emergencyPhoneController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _nidController.dispose();
    _emergencyNameController.dispose();
    _emergencyPhoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final members = ref.watch(membersUiStateProvider);

    final title = widget.mode == MemberFormMode.add
        ? 'Add member'
        : 'Edit member';

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: members.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(AppSpacing.s16),
          child: AppLoadingState(),
        ),
        error: (error, stack) => const Padding(
          padding: EdgeInsets.all(AppSpacing.s16),
          child: AppErrorState(message: 'Failed to load members.'),
        ),
        data: (state) {
          if (state == null) {
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.s16),
              child: AppEmptyState(
                title: 'No Shomiti found',
                message: 'Create a Shomiti first, then add members.',
                icon: Icons.group_outlined,
              ),
            );
          }

          Member? existing;
          if (widget.mode == MemberFormMode.edit && widget.memberId != null) {
            for (final member in state.members) {
              if (member.id == widget.memberId) {
                existing = member;
                break;
              }
            }
            if (existing == null) {
              return const Padding(
                padding: EdgeInsets.all(AppSpacing.s16),
                child: AppEmptyState(
                  title: 'Member not found',
                  message: 'This member may have been removed from the list.',
                  icon: Icons.person_off_outlined,
                ),
              );
            }
          }

          if (existing != null && _fullNameController.text.isEmpty) {
            _fullNameController.text = existing.fullName;
            _phoneController.text = existing.phone ?? '';
            _addressController.text = existing.addressOrWorkplace ?? '';
            _nidController.text = existing.nidOrPassport ?? '';
            _emergencyNameController.text = existing.emergencyContactName ?? '';
            _emergencyPhoneController.text =
                existing.emergencyContactPhone ?? '';
            _notesController.text = existing.notes ?? '';
          }

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.s16),
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    AppTextField(
                      label: 'Full name',
                      fieldKey: const Key('member_full_name'),
                      controller: _fullNameController,
                      validator: _required,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: AppSpacing.s12),
                    AppTextField(
                      label: 'Phone',
                      fieldKey: const Key('member_phone'),
                      controller: _phoneController,
                      validator: _required,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: AppSpacing.s12),
                    AppTextField(
                      label: 'Address / workplace',
                      fieldKey: const Key('member_address'),
                      controller: _addressController,
                      validator: _required,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: AppSpacing.s12),
                    AppTextField(
                      label: 'NID / Passport (optional)',
                      fieldKey: const Key('member_nid'),
                      controller: _nidController,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: AppSpacing.s12),
                    AppTextField(
                      label: 'Emergency contact name',
                      fieldKey: const Key('member_emergency_name'),
                      controller: _emergencyNameController,
                      validator: _required,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: AppSpacing.s12),
                    AppTextField(
                      label: 'Emergency contact phone',
                      fieldKey: const Key('member_emergency_phone'),
                      controller: _emergencyPhoneController,
                      validator: _required,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: AppSpacing.s12),
                    AppTextField(
                      label: 'Notes (optional)',
                      fieldKey: const Key('member_notes'),
                      controller: _notesController,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.s24),
              AppButton.primary(
                key: const Key('member_save'),
                label: 'Save',
                onPressed: () => _save(
                  context,
                  shomitiId: state.shomitiId,
                  isJoiningClosed: state.isJoiningClosed,
                  existing: existing,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required';
    return null;
  }

  Future<void> _save(
    BuildContext context, {
    required String shomitiId,
    required bool isJoiningClosed,
    Member? existing,
  }) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final profile = MemberProfileInput(
      fullName: _fullNameController.text,
      phone: _phoneController.text,
      addressOrWorkplace: _addressController.text,
      emergencyContactName: _emergencyNameController.text,
      emergencyContactPhone: _emergencyPhoneController.text,
      nidOrPassport: _nidController.text,
      notes: _notesController.text,
    );

    try {
      if (widget.mode == MemberFormMode.add) {
        await ref.read(addMemberProvider)(
          shomitiId: shomitiId,
          profile: profile,
          isJoiningClosed: isJoiningClosed,
        );
      } else {
        if (existing == null) return;
        await ref.read(updateMemberProvider)(
          shomitiId: shomitiId,
          memberId: existing.id,
          profile: profile,
        );
      }
    } on MemberJoiningClosedException {
      if (!context.mounted) return;
      await showDialog<void>(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Joining is closed'),
          content: Text(
            'New members cannot be added after the start date unless everyone unanimously agrees.',
          ),
        ),
      );
      return;
    } on MemberDuplicateException catch (e) {
      final label = switch (e.field) {
        MemberDuplicateField.phone => 'phone number',
        MemberDuplicateField.nidOrPassport => 'NID/passport',
      };
      if (!context.mounted) return;
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Potential duplicate'),
          content: Text(
            'Another member already uses this $label. Verify identity before proceeding.',
          ),
          actions: [
            TextButton(
              key: const Key('member_duplicate_ok'),
              onPressed: () => context.pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    } on MemberWriteException catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
      return;
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to save member.')));
      return;
    }

    if (!context.mounted) return;
    context.pop();
  }
}

enum MemberFormMode { add, edit }

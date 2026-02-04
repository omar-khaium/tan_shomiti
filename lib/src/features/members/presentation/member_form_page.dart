import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_text_field.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import 'providers/members_demo_providers.dart';

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
    final membersState = ref.watch(membersDemoControllerProvider).valueOrNull;
    MembersDemoMember? existing;
    if (widget.mode == MemberFormMode.edit &&
        widget.memberId != null &&
        membersState != null) {
      for (final member in membersState.members) {
        if (member.id == widget.memberId) {
          existing = member;
          break;
        }
      }
    }

    if (existing != null && _fullNameController.text.isEmpty) {
      _fullNameController.text = existing.fullName;
      _phoneController.text = existing.phone;
      _addressController.text = existing.addressOrWorkplace;
      _nidController.text = existing.nidOrPassport ?? '';
      _emergencyNameController.text = existing.emergencyContactName;
      _emergencyPhoneController.text = existing.emergencyContactPhone;
      _notesController.text = existing.notes ?? '';
    }

    final title = widget.mode == MemberFormMode.add
        ? 'Add member'
        : 'Edit member';

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
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
            onPressed: () => _save(context, existing: existing),
          ),
        ],
      ),
    );
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required';
    return null;
  }

  Future<void> _save(
    BuildContext context, {
    MembersDemoMember? existing,
  }) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final notifier = ref.read(membersDemoControllerProvider.notifier);
    final id = existing?.id ?? notifier.newMemberId();

    final member = MembersDemoMember(
      id: id,
      fullName: _fullNameController.text.trim(),
      phone: _phoneController.text.trim(),
      addressOrWorkplace: _addressController.text.trim(),
      emergencyContactName: _emergencyNameController.text.trim(),
      emergencyContactPhone: _emergencyPhoneController.text.trim(),
      nidOrPassport: _nidController.text.trim().isEmpty
          ? null
          : _nidController.text.trim(),
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
      isActive: existing?.isActive ?? true,
      createdAt: existing?.createdAt ?? DateTime.now(),
    );

    await notifier.upsertMember(member);

    if (!context.mounted) return;
    context.pop();
  }
}

enum MemberFormMode { add, edit }

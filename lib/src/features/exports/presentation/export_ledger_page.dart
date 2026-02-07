import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/components/app_text_field.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import '../domain/entities/export_format.dart';
import '../domain/entities/export_redaction.dart';
import '../domain/entities/export_result.dart';
import 'providers/exports_providers.dart';

class ExportLedgerPage extends ConsumerStatefulWidget {
  const ExportLedgerPage({super.key});

  @override
  ConsumerState<ExportLedgerPage> createState() => _ExportLedgerPageState();
}

class _ExportLedgerPageState extends ConsumerState<ExportLedgerPage> {
  ExportFormat _format = ExportFormat.csv;
  int _limit = 100;
  bool _includeNotes = ExportRedaction.defaults().includeFreeTextNotes;

  bool _confirmConsent = false;
  ExportResult? _lastExport;
  bool _generating = false;
  bool _sharing = false;

  final _consentRefController = TextEditingController();

  @override
  void dispose() {
    _consentRefController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Export ledger')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.s16),
        children: [
          const AppCard(
            child: Text(
              'Exports will be privacy-safe by default and can be shared only with consent.',
              key: Key('export_ledger_notice'),
            ),
          ),
          const SizedBox(height: AppSpacing.s16),
          KeyedSubtree(
            key: ValueKey('export_ledger_format_${_format.name}'),
            child: DropdownButtonFormField<ExportFormat>(
              key: const Key('export_ledger_format'),
              initialValue: _format,
              items: const [
                DropdownMenuItem(value: ExportFormat.csv, child: Text('CSV')),
                DropdownMenuItem(
                  value: ExportFormat.pdf,
                  enabled: false,
                  child: Text('PDF (coming soon)'),
                ),
              ],
              onChanged: _generating || _sharing
                  ? null
                  : (value) => setState(() {
                        _format = value ?? ExportFormat.csv;
                        _lastExport = null;
                      }),
              decoration: const InputDecoration(labelText: 'Format'),
            ),
          ),
          const SizedBox(height: AppSpacing.s12),
          KeyedSubtree(
            key: ValueKey('export_ledger_limit_$_limit'),
            child: DropdownButtonFormField<int>(
              key: const Key('export_ledger_limit'),
              initialValue: _limit,
              items: const [
                DropdownMenuItem(value: 50, child: Text('Latest 50')),
                DropdownMenuItem(value: 100, child: Text('Latest 100')),
                DropdownMenuItem(value: 200, child: Text('Latest 200')),
              ],
              onChanged: _generating || _sharing
                  ? null
                  : (value) => setState(() {
                        _limit = value ?? 100;
                        _lastExport = null;
                      }),
              decoration: const InputDecoration(labelText: 'Scope'),
            ),
          ),
          const SizedBox(height: AppSpacing.s12),
          SwitchListTile(
            key: const Key('export_ledger_include_notes'),
            value: _includeNotes,
            onChanged: _generating || _sharing
                ? null
                : (v) => setState(() {
                      _includeNotes = v;
                      _lastExport = null;
                    }),
            title: const Text('Include free-text notes'),
            subtitle: const Text('Default off for privacy.'),
          ),
          const SizedBox(height: AppSpacing.s12),
          AppButton.primary(
            key: const Key('export_ledger_generate'),
            label: _generating ? 'Generating…' : 'Generate export',
            onPressed: _generating || _sharing ? null : _generate,
          ),
          if (_lastExport != null) ...[
            const SizedBox(height: AppSpacing.s12),
            Text(
              'Saved: ${_lastExport!.filePath}',
              key: const Key('export_ledger_path'),
            ),
            const SizedBox(height: AppSpacing.s12),
            CheckboxListTile(
              key: const Key('export_ledger_consent_check'),
              value: _confirmConsent,
              onChanged: _sharing
                  ? null
                  : (v) => setState(() {
                        _confirmConsent = v ?? false;
                      }),
              title: const Text(
                'I have consent to share this outside the group',
              ),
            ),
            AppTextField(
              fieldKey: const Key('export_ledger_consent_ref'),
              label: 'Consent reference (required to share)',
              hint: 'e.g., chat msg id',
              controller: _consentRefController,
              enabled: !_sharing,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: AppSpacing.s12),
            AppButton.secondary(
              key: const Key('export_ledger_share'),
              label: _sharing ? 'Sharing…' : 'Share',
              onPressed: (_confirmConsent &&
                      _consentRefController.text.trim().isNotEmpty &&
                      !_sharing)
                  ? _share
                  : null,
            ),
          ],
        ],
      ),
    );
  }

  ExportRedaction _redaction() => ExportRedaction(
        includeFreeTextNotes: _includeNotes,
        includeMemberNames: false,
        includeProofReferences: true,
      );

  Future<void> _generate() async {
    setState(() {
      _generating = true;
      _lastExport = null;
      _confirmConsent = false;
      _consentRefController.text = '';
    });

    try {
      final export = await ref.read(generateLedgerExportProvider)(
            limit: _limit,
            format: _format,
            redaction: _redaction(),
            now: DateTime.now(),
          );
      setState(() => _lastExport = export);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Export generated.')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to export: $e')),
      );
    } finally {
      if (mounted) setState(() => _generating = false);
    }
  }

  Future<void> _share() async {
    final export = _lastExport;
    if (export == null) return;

    setState(() => _sharing = true);
    try {
      await ref.read(shareExportProvider)(
            export: export,
            consentReference: _consentRefController.text,
            now: DateTime.now(),
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Share sheet opened.')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to share: $e')),
      );
    } finally {
      if (mounted) setState(() => _sharing = false);
    }
  }
}

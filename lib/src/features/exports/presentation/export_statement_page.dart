import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/components/app_error_state.dart';
import '../../../core/ui/components/app_loading_state.dart';
import '../../../core/ui/components/app_text_field.dart';
import '../../../core/ui/formatters/billing_month_label.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import '../../contributions/domain/value_objects/billing_month.dart';
import '../../shomiti_setup/presentation/providers/shomiti_setup_providers.dart';
import '../../statements/presentation/providers/statements_domain_providers.dart';
import '../domain/entities/export_format.dart';
import '../domain/entities/export_redaction.dart';
import '../domain/entities/export_result.dart';
import 'providers/exports_providers.dart';

class ExportStatementPage extends ConsumerStatefulWidget {
  const ExportStatementPage({super.key});

  @override
  ConsumerState<ExportStatementPage> createState() =>
      _ExportStatementPageState();
}

class _ExportStatementPageState extends ConsumerState<ExportStatementPage> {
  BillingMonth _month = BillingMonth.fromDate(DateTime.now());
  ExportFormat _format = ExportFormat.csv;
  bool _includeMemberNames = ExportRedaction.defaults().includeMemberNames;
  bool _includeNotes = ExportRedaction.defaults().includeFreeTextNotes;
  bool _includeProofReferences =
      ExportRedaction.defaults().includeProofReferences;

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
    final shomitiAsync = ref.watch(activeShomitiProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Export statement')),
      body: shomitiAsync.when(
          loading: () => const Center(child: AppLoadingState()),
          error: (error, stack) => Center(
            child: AppErrorState(
              message: 'Failed to load shomiti.',
              onRetry: () => ref.invalidate(activeShomitiProvider),
            ),
          ),
          data: (shomiti) {
            if (shomiti == null) {
              return const AppCard(
                child: Text('Shomiti is not configured.'),
              );
            }

            final statementAsync = ref.watch(
              statementByMonthProvider(
                StatementMonthArgs(
                  shomitiId: shomiti.id,
                  month: _month,
                ),
              ),
            );

            final monthLabel = formatBillingMonthLabel(_month);

            return ListView(
              padding: const EdgeInsets.all(AppSpacing.s16),
              children: [
                Row(
                  children: [
                    IconButton(
                      key: const Key('export_statement_prev_month'),
                      onPressed: _generating || _sharing
                          ? null
                          : () => setState(() {
                                _month = _month.previous();
                                _lastExport = null;
                              }),
                      icon: const Icon(Icons.chevron_left),
                      tooltip: 'Previous month',
                    ),
                    Expanded(
                      child: Text(
                        monthLabel,
                        key: const Key('export_statement_month_label'),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                      key: const Key('export_statement_next_month'),
                      onPressed: _generating || _sharing
                          ? null
                          : () => setState(() {
                                _month = _month.next();
                                _lastExport = null;
                              }),
                      icon: const Icon(Icons.chevron_right),
                      tooltip: 'Next month',
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.s16),
                AppCard(
                  child: statementAsync.when(
                    loading: () => const AppLoadingState(),
                    error: (error, stack) => const Text(
                      'Failed to load statement.',
                      key: Key('export_statement_error'),
                    ),
                    data: (statement) {
                      if (statement == null) {
                        return const Text(
                          'No statement generated for this month yet.',
                          key: Key('export_statement_empty'),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Statement found.',
                            key: Key('export_statement_ready'),
                          ),
                          const SizedBox(height: AppSpacing.s12),
                          KeyedSubtree(
                            key: ValueKey(
                              'export_statement_format_${_format.name}',
                            ),
                            child: DropdownButtonFormField<ExportFormat>(
                              key: const Key('export_statement_format'),
                              initialValue: _format,
                              items: const [
                                DropdownMenuItem(
                                  value: ExportFormat.csv,
                                  child: Text('CSV'),
                                ),
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
                              decoration: const InputDecoration(
                                labelText: 'Format',
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.s12),
                          SwitchListTile(
                            key: const Key('export_statement_include_names'),
                            value: _includeMemberNames,
                            onChanged: _generating || _sharing
                                ? null
                                : (v) => setState(() {
                                      _includeMemberNames = v;
                                      _lastExport = null;
                                    }),
                            title: const Text('Include member names'),
                            subtitle: const Text('Default off for privacy.'),
                          ),
                          SwitchListTile(
                            key: const Key('export_statement_include_proof_refs'),
                            value: _includeProofReferences,
                            onChanged: _generating || _sharing
                                ? null
                                : (v) => setState(() {
                                      _includeProofReferences = v;
                                      _lastExport = null;
                                    }),
                            title: const Text('Include proof references'),
                            subtitle: const Text('Links/ids (still sensitive).'),
                          ),
                          SwitchListTile(
                            key: const Key('export_statement_include_notes'),
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
                          Row(
                            children: [
                              Expanded(
                                child: AppButton.primary(
                                  key: const Key('export_statement_generate'),
                                  label: _generating
                                      ? 'Generating…'
                                      : 'Generate export',
                                  onPressed: _generating || _sharing
                                      ? null
                                      : () => _generate(
                                            shomitiId: shomiti.id,
                                            month: _month,
                                          ),
                                ),
                              ),
                            ],
                          ),
                          if (_lastExport != null) ...[
                            const SizedBox(height: AppSpacing.s12),
                            Text(
                              'Saved: ${_lastExport!.filePath}',
                              key: const Key('export_statement_path'),
                            ),
                            const SizedBox(height: AppSpacing.s12),
                            CheckboxListTile(
                              key: const Key('export_statement_consent_check'),
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
                              fieldKey:
                                  const Key('export_statement_consent_ref'),
                              label: 'Consent reference (required to share)',
                              hint: 'e.g., chat msg id',
                              controller: _consentRefController,
                              enabled: !_sharing,
                              onChanged: (_) => setState(() {}),
                            ),
                            const SizedBox(height: AppSpacing.s12),
                            AppButton.secondary(
                              key: const Key('export_statement_share'),
                              label: _sharing ? 'Sharing…' : 'Share',
                              onPressed: (_confirmConsent &&
                                      _consentRefController.text
                                          .trim()
                                          .isNotEmpty &&
                                      !_sharing)
                                  ? _share
                                  : null,
                            ),
                          ],
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.s16),
              ],
            );
          },
        ),
    );
  }

  ExportRedaction _redaction() => ExportRedaction(
        includeFreeTextNotes: _includeNotes,
        includeMemberNames: _includeMemberNames,
        includeProofReferences: _includeProofReferences,
      );

  Future<void> _generate({
    required String shomitiId,
    required BillingMonth month,
  }) async {
    setState(() {
      _generating = true;
      _lastExport = null;
      _confirmConsent = false;
      _consentRefController.text = '';
    });

    try {
      final export = await ref.read(generateStatementExportProvider)(
            shomitiId: shomitiId,
            month: month,
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

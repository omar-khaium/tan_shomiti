import 'package:flutter/material.dart';

import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/tokens/app_spacing.dart';

class RedoDrawPage extends StatefulWidget {
  const RedoDrawPage({super.key});

  @override
  State<RedoDrawPage> createState() => _RedoDrawPageState();
}

class _RedoDrawPageState extends State<RedoDrawPage> {
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canConfirm = _reasonController.text.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text('Redo draw')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AppCard(
              child: Text(
                'Redo should be used only when the draw is compromised.',
              ),
            ),
            const SizedBox(height: AppSpacing.s16),
            TextField(
              key: const Key('redo_reason'),
              controller: _reasonController,
              decoration: const InputDecoration(
                labelText: 'Reason',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              onChanged: (_) => setState(() {}),
            ),
            const Spacer(),
            AppButton.primary(
              key: const Key('redo_confirm'),
              label: 'Invalidate and redo',
              onPressed: canConfirm ? () => Navigator.of(context).pop() : null,
            ),
          ],
        ),
      ),
    );
  }
}


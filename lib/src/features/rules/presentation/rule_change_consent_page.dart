import 'package:flutter/material.dart';

import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/tokens/app_spacing.dart';

class RuleChangeConsentPage extends StatelessWidget {
  const RuleChangeConsentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Collect consent')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.s16),
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Consent',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.s8),
                const Text(
                  'Consent collection and thresholds are implemented in Stage 3.',
                  key: Key('rule_change_consent_placeholder'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';

import '../tokens/app_spacing.dart';
import 'app_button.dart';

class AppErrorState extends StatelessWidget {
  const AppErrorState({
    required this.message,
    super.key,
    this.onRetry,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(message),
        if (onRetry != null) ...[
          const SizedBox(height: AppSpacing.s12),
          AppButton.primary(label: 'Retry', onPressed: onRetry),
        ],
      ],
    );
  }
}


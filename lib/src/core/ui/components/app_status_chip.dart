import 'package:flutter/material.dart';

import '../tokens/app_colors.dart';

class AppStatusChip extends StatelessWidget {
  const AppStatusChip({
    required this.label,
    required this.kind,
    super.key,
  });

  final String label;
  final AppStatusKind kind;

  @override
  Widget build(BuildContext context) {
    final (background, foreground) = switch (kind) {
      AppStatusKind.success => (AppColors.success.withValues(alpha: 0.12), AppColors.success),
      AppStatusKind.warning => (AppColors.warning.withValues(alpha: 0.16), AppColors.warning),
      AppStatusKind.error => (AppColors.error.withValues(alpha: 0.12), AppColors.error),
      AppStatusKind.info => (AppColors.info.withValues(alpha: 0.12), AppColors.info),
    };

    return Chip(
      label: Text(label),
      backgroundColor: background,
      labelStyle: TextStyle(color: foreground),
      side: BorderSide(color: foreground.withValues(alpha: 0.28)),
    );
  }
}

enum AppStatusKind {
  success,
  warning,
  error,
  info,
}


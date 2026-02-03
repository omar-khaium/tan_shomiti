import 'package:flutter/material.dart';

import 'app_button.dart';

Future<bool?> showAppConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  required String confirmLabel,
  String cancelLabel = 'Cancel',
  Key? cancelKey,
  Key? confirmKey,
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        AppButton.tertiary(
          key: cancelKey,
          label: cancelLabel,
          onPressed: () => Navigator.of(context).pop(false),
        ),
        AppButton.primary(
          key: confirmKey,
          label: confirmLabel,
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );
}

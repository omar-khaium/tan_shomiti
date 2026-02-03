import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton._({
    required _AppButtonVariant variant,
    required this.label,
    required this.onPressed,
    required this.isLoading,
    super.key,
  }) : _variant = variant;

  factory AppButton.primary({
    required String label,
    required VoidCallback? onPressed,
    bool isLoading = false,
    Key? key,
  }) {
    return AppButton._(
      variant: _AppButtonVariant.primary,
      label: label,
      onPressed: onPressed,
      isLoading: isLoading,
      key: key,
    );
  }

  factory AppButton.secondary({
    required String label,
    required VoidCallback? onPressed,
    bool isLoading = false,
    Key? key,
  }) {
    return AppButton._(
      variant: _AppButtonVariant.secondary,
      label: label,
      onPressed: onPressed,
      isLoading: isLoading,
      key: key,
    );
  }

  factory AppButton.tertiary({
    required String label,
    required VoidCallback? onPressed,
    bool isLoading = false,
    Key? key,
  }) {
    return AppButton._(
      variant: _AppButtonVariant.tertiary,
      label: label,
      onPressed: onPressed,
      isLoading: isLoading,
      key: key,
    );
  }

  final _AppButtonVariant _variant;
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = isLoading ? null : onPressed;
    final child = isLoading
        ? const SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Text(label);

    return switch (_variant) {
      _AppButtonVariant.primary => FilledButton(
          onPressed: effectiveOnPressed,
          child: child,
        ),
      _AppButtonVariant.secondary => OutlinedButton(
          onPressed: effectiveOnPressed,
          child: child,
        ),
      _AppButtonVariant.tertiary => TextButton(
          onPressed: effectiveOnPressed,
          child: child,
        ),
    };
  }
}

enum _AppButtonVariant {
  primary,
  secondary,
  tertiary,
}

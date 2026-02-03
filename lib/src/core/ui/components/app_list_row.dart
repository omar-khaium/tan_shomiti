import 'package:flutter/material.dart';

class AppListRow extends StatelessWidget {
  const AppListRow({
    required this.title,
    required this.value,
    super.key,
    this.onTap,
  });

  final String title;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}


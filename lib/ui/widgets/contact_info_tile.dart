import 'package:flutter/material.dart';

class ContactInfoTile extends StatelessWidget {
  const ContactInfoTile({
    required this.label,
    required this.value,
    required this.icon,
    this.trailing,
    super.key,
  });

  final String label;
  final String value;
  final IconData icon;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    if (value.trim().isEmpty) {
      return const SizedBox.shrink();
    }
    final ColorScheme colors = Theme.of(context).colorScheme;
    return ListTile(
      leading: Icon(icon, color: colors.onSurfaceVariant),
      title: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(color: colors.onSurfaceVariant),
      ),
      subtitle: Text(value, style: Theme.of(context).textTheme.bodyLarge),
      trailing: trailing,
    );
  }
}

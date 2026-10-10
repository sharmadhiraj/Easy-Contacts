import 'package:easy_contacts/models/group.dart';
import 'package:flutter/material.dart';

class GroupListTile extends StatelessWidget {
  const GroupListTile({
    required this.group,
    required this.onSelectGroup,
    required this.onDeleteGroup,
    required this.selected,
    super.key,
  });

  final void Function(String id) onSelectGroup;
  final void Function(Group group) onDeleteGroup;
  final Group group;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Dismissible(
      key: ValueKey(group.id),
      direction: DismissDirection.endToStart,
      background: ColoredBox(
        color: colors.errorContainer,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Icon(Icons.delete_outline, color: colors.onErrorContainer),
          ),
        ),
      ),
      onDismissed: (_) => onDeleteGroup(group),
      child: Semantics(
        button: true,
        selected: selected,
        label: "Select group ${group.name}",
        child: ListTile(
          onTap: () => onSelectGroup(group.id),
          title: Text(group.name),
          trailing: Icon(
            selected ? Icons.check_circle : Icons.circle_outlined,
            color: selected ? colors.primary : colors.outline,
          ),
        ),
      ),
    );
  }
}

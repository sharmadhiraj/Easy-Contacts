import 'package:easy_contacts/models/group.dart';
import 'package:easy_contacts/utils/constant.dart';
import 'package:flutter/material.dart';

class GroupListTile extends StatelessWidget {
  const GroupListTile({
    required this.group,
    required this.onSelectGroup,
    required this.selected,
    super.key,
  });

  final Function(String id) onSelectGroup;
  final Group group;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onSelectGroup(group.id),
        title: Text(group.name),
        trailing: Icon(
          Icons.check_circle_rounded,
          color: selected ? Constant.primaryColor : Colors.grey,
          size: 32,
        ),
      ),
    );
  }
}

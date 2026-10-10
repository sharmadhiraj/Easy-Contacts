import 'package:easy_contacts/app/route.dart';
import 'package:easy_contacts/models/group.dart';
import 'package:easy_contacts/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GroupSelector extends StatefulWidget {
  const GroupSelector({
    required this.selectedGroups,
    required this.onSelectGroups,
    super.key,
  });

  final List<Group> selectedGroups;
  final Function(List<Group>) onSelectGroups;

  @override
  State<GroupSelector> createState() => _GroupSelectorState();
}

class _GroupSelectorState extends State<GroupSelector> {
  List<Group> _selectedGroups = [];

  @override
  void initState() {
    super.initState();
    _selectedGroups = widget.selectedGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: "Select groups",
      child: InkWell(
        onTap: _selectGroups,
        child: InputDecorator(
          isEmpty: _selectedGroups.isEmpty,
          decoration: const InputDecoration(
            labelText: "Groups",
            suffixIcon: Icon(Icons.chevron_right),
          ),
          child: Text(CommonUtil.formatGroupNames(_selectedGroups)),
        ),
      ),
    );
  }

  Future<void> _selectGroups() async {
    final dynamic groups = await context.pushNamed(
      AppRoute.groups.name,
      extra: _selectedGroups.map((e) => e.id).toList(),
    );
    if (groups is List<Group>) {
      setState(() => _selectedGroups = groups);
      widget.onSelectGroups(_selectedGroups);
    }
  }
}

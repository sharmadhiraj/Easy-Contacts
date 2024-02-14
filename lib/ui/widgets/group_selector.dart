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
    return GestureDetector(
      onTap: _selectGroups,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          Text(
            "Groups",
            style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontSize: 13,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              _selectedGroups.isEmpty
                  ? "Tap to select groups"
                  : CommonUtil.formatGroupNames(_selectedGroups),
              style: TextStyle(
                fontSize: 16,
                color: _selectedGroups.isEmpty ? Colors.grey : Colors.black87,
              ),
            ),
          ),
          const Divider(
            thickness: 2,
            color: Colors.black26,
          ),
        ],
      ),
    );
  }

  void _selectGroups() async {
    dynamic groups = await context.pushNamed(
      AppRoute.groups.name,
      extra: _selectedGroups.map((e) => e.id).toList(),
    );
    if (groups is List<Group>) {
      setState(() => _selectedGroups = groups);
      widget.onSelectGroups(_selectedGroups);
    }
  }
}

import 'package:easy_contacts/app/locator.dart';
import 'package:easy_contacts/models/group.dart';
import 'package:easy_contacts/ui/widgets/empty_list_label.dart';
import 'package:easy_contacts/ui/widgets/group_list_tile.dart';
import 'package:easy_contacts/ui/widgets/group_name_input.dart';
import 'package:easy_contacts/view_models/groups.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
      bottomSheet: const GroupNameInput(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Groups"),
      actions: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.done),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return ViewModelBuilder<GroupsViewModel>.reactive(
      viewModelBuilder: () => locator<GroupsViewModel>(),
      disposeViewModel: false,
      builder: (context, model, _) =>
          model.hasGroups() ? _buildListView(model) : _buildNoGroups(),
    );
  }

  Widget _buildNoGroups() {
    return const EmptyListLabel(
      message: "No groups have been created yet.\n"
          "You can create a new group below.",
    );
  }

  Widget _buildListView(GroupsViewModel model) {
    final List<Group> groups = model.getGroups();
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 96),
      itemBuilder: (context, index) => GroupListTile(
        group: groups[index],
        selected: model.isSelectedGroup(groups[index]),
      ),
      itemCount: groups.length,
    );
  }
}

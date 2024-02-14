import 'package:easy_contacts/models/group.dart';
import 'package:easy_contacts/ui/widgets/empty_list_label.dart';
import 'package:easy_contacts/ui/widgets/group_list_tile.dart';
import 'package:easy_contacts/ui/widgets/group_name_input.dart';
import 'package:easy_contacts/view_models/groups.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({
    required this.selectedIds,
    Key? key,
  }) : super(key: key);

  final List<String> selectedIds;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GroupsViewModel>.reactive(
      viewModelBuilder: () => GroupsViewModel(selectedIds: selectedIds),
      builder: (context, viewModel, _) {
        return Scaffold(
          appBar: _buildAppBar(context, viewModel.getSelectedGroups()),
          body: _buildBody(viewModel),
          bottomSheet: GroupNameInput(viewModel: viewModel),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context, List<Group> selectedGroups) {
    return AppBar(
      title: const Text("Groups"),
      actions: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(selectedGroups),
          icon: const Icon(Icons.done),
        ),
      ],
    );
  }

  Widget _buildBody(GroupsViewModel viewModel) {
    return viewModel.hasGroups() ? _buildListView(viewModel) : _buildNoGroups();
  }

  Widget _buildNoGroups() {
    return const EmptyListLabel(
      message: "No groups have been created yet.\n"
          "You can create a new group below.",
    );
  }

  Widget _buildListView(GroupsViewModel viewModel) {
    final List<Group> groups = viewModel.getGroups();
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 96),
      itemBuilder: (context, index) => GroupListTile(
        viewModel: viewModel,
        group: groups[index],
        selected: viewModel.isSelectedGroup(
          groups[index],
        ),
      ),
      itemCount: groups.length,
    );
  }
}

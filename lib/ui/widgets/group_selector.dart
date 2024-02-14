import 'package:easy_contacts/app/locator.dart';
import 'package:easy_contacts/app/route.dart';
import 'package:easy_contacts/view_models/groups.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';

class GroupSelector extends StatelessWidget {
  const GroupSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GroupsViewModel>.reactive(
      viewModelBuilder: () => locator<GroupsViewModel>(),
      disposeViewModel: false,
      builder: (context, model, _) {
        return GestureDetector(
          onTap: () => context.pushNamed(AppRoute.groups.name),
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
                  model.getSelectedIds().isEmpty
                      ? "Tap to select groups"
                      : model
                          .getSelectedGroups()
                          .map((group) => group.name)
                          .join(", "),
                  style: TextStyle(
                    fontSize: 16,
                    color: model.getSelectedIds().isEmpty
                        ? Colors.grey
                        : Colors.black87,
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
      },
    );
  }
}

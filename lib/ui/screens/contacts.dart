import 'package:easy_contacts/app/locator.dart';
import 'package:easy_contacts/app/route.dart';
import 'package:easy_contacts/models/contact.dart';
import 'package:easy_contacts/ui/widgets/add_edit_contact.dart';
import 'package:easy_contacts/ui/widgets/empty_list_label.dart';
import 'package:easy_contacts/ui/widgets/search_input.dart';
import 'package:easy_contacts/utils/constant.dart';
import 'package:easy_contacts/view_models/contacts.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(title: const Text(Constant.appName));
  }

  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => AddEditContactWidget.show(context: context),
      backgroundColor: Constant.primaryColor,
      child: const Icon(Icons.add),
    );
  }

  Widget _buildBody() {
    return ViewModelBuilder<ContactsViewModel>.reactive(
      viewModelBuilder: () => locator<ContactsViewModel>(),
      builder: (context, model, _) {
        return model.hasContacts()
            ? _buildContactsWithSearch(model.getContacts())
            : _buildNoContacts();
      },
    );
  }

  Widget _buildNoContacts() {
    return const EmptyListLabel(
      message: "You currently have no contacts.\n"
          "Tap the '+' button in the bottom corner to create a new contact.",
    );
  }

  Widget _buildNoResults() {
    return const EmptyListLabel(
      message: "Your search returned no contacts.\n"
          "Please try searching with a different name.",
    );
  }

  Widget _buildContactsWithSearch(List<Contact> contacts) {
    return Column(
      children: [
        const SearchInput(),
        Expanded(
          child: contacts.isEmpty
              ? _buildNoResults()
              : ListView.builder(
                  itemBuilder: (context, index) =>
                      _buildListItem(context, contacts[index]),
                  itemCount: contacts.length,
                ),
        )
      ],
    );
  }

  Widget _buildListItem(BuildContext context, Contact contact) {
    return Card(
      child: ListTile(
        onTap: () => context.pushNamed(
          AppRoute.contactDetail.name,
          extra: contact.id,
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.black12,
          child: Text(
            contact.getAvatar(),
            style: const TextStyle(
              fontSize: 16,
              color: Constant.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          contact.getFullName(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          contact.phoneNo,
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: Constant.primaryColor,
        ),
      ),
    );
  }
}

import 'package:easy_contacts/app/locator.dart';
import 'package:easy_contacts/models/contact.dart';
import 'package:easy_contacts/ui/widgets/add_edit_contact.dart';
import 'package:easy_contacts/ui/widgets/contact_list_tile.dart';
import 'package:easy_contacts/ui/widgets/empty_list_label.dart';
import 'package:easy_contacts/ui/widgets/search_input.dart';
import 'package:easy_contacts/utils/constant.dart';
import 'package:easy_contacts/view_models/contacts.viewmodel.dart';
import 'package:easy_contacts/ui/widgets/content_width.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ContentWidth(child: _buildBody()),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(title: const Text(Constant.appName));
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => AddEditContactWidget.show(context: context),
      icon: const Icon(Icons.add),
      label: const Text("New contact"),
    );
  }

  Widget _buildBody() {
    return ViewModelBuilder<ContactsViewModel>.reactive(
      viewModelBuilder: locator.call,
      builder: (context, model, _) {
        return model.hasContacts()
            ? _buildContactsWithSearch(model.getContacts())
            : _buildNoContacts();
      },
    );
  }

  Widget _buildNoContacts() {
    return const EmptyListLabel(
      icon: Icons.contacts_outlined,
      title: "No contacts yet",
      message: "Tap \"New contact\" to add your first one.",
    );
  }

  Widget _buildNoResults() {
    return const EmptyListLabel(
      icon: Icons.search_off,
      title: "No results",
      message: "Try searching with a different name.",
    );
  }

  Widget _buildContactsWithSearch(List<Contact> contacts) {
    return Column(
      children: [
        const SearchInput(),
        Expanded(
          child:
              contacts.isEmpty ? _buildNoResults() : _buildListView(contacts),
        ),
      ],
    );
  }

  Widget _buildListView(List<Contact> contacts) {
    return ListView.builder(
      itemBuilder: (context, index) =>
          ContactListTile(contact: contacts[index]),
      itemCount: contacts.length,
      padding: const EdgeInsets.only(bottom: 88),
    );
  }
}

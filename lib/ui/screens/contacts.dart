import 'package:easy_contacts/models/contact.dart';
import 'package:easy_contacts/ui/widgets/add_contact.dart';
import 'package:easy_contacts/utils/constant.dart';
import 'package:easy_contacts/viewmodels/contacts_viewmodel.dart';
import 'package:flutter/material.dart';
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
      onPressed: () => AddContactBottomSheet.show(context),
      backgroundColor: Constant.primaryColor,
      child: const Icon(Icons.add),
    );
  }

  Widget _buildBody() {
    return ViewModelBuilder<ContactScreenViewModel>.reactive(
      viewModelBuilder: () => ContactScreenViewModel(),
      builder: (context, model, _) {
        return model.hasContacts()
            ? _buildListView(model.getContacts())
            : _buildNoContacts();
      },
    );
  }

  Widget _buildNoContacts() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "You currently have no contacts.\n"
          "Tap the '+' button in the bottom corner to create a new contact.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildListView(List<Contact> contacts) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _buildListItem(contacts[index]);
      },
      itemCount: contacts.length,
    );
  }

  Widget _buildListItem(Contact contact) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.black54,
          child: Text(
            contact.getAvatar(),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(contact.getFullName()),
        subtitle: Text(
          contact.phoneNo,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: Constant.primaryColor,
        ),
      ),
    );
  }
}

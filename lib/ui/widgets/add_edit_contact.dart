import 'package:easy_contacts/app/route.dart';
import 'package:easy_contacts/models/contact.dart';
import 'package:easy_contacts/models/group.dart';
import 'package:easy_contacts/ui/widgets/group_selector.dart';
import 'package:easy_contacts/view_models/contact_add_edit.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';

class AddEditContactWidget extends StatelessWidget {
  const AddEditContactWidget({this.contact, Key? key}) : super(key: key);

  final Contact? contact;

  static void show({
    required BuildContext context,
    Contact? contact,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) => AddEditContactWidget(contact: contact),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ContactAddEditViewModel>.reactive(
      viewModelBuilder: () => ContactAddEditViewModel(contact: contact),
      builder: (context, viewModel, _) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20).copyWith(
                bottom: MediaQuery.of(context).viewInsets.bottom + 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 4),
                Center(
                  child: Text(
                    viewModel.isUpdate ? "Update Contact" : "Add New Contact",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: viewModel.contact.firstName,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  onChanged: viewModel.setFirstName,
                  decoration: const InputDecoration(labelText: "First Name"),
                ),
                TextFormField(
                  initialValue: viewModel.contact.lastName,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  onChanged: viewModel.setLastName,
                  decoration: const InputDecoration(labelText: "Last Name"),
                ),
                TextFormField(
                  initialValue: viewModel.contact.phoneNo,
                  keyboardType: TextInputType.phone,
                  onChanged: viewModel.setPhoneNo,
                  decoration: const InputDecoration(labelText: "Phone Number"),
                ),
                TextFormField(
                  initialValue: viewModel.contact.nickName,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  onChanged: viewModel.setNickName,
                  decoration: const InputDecoration(labelText: "Nick Name"),
                ),
                TextFormField(
                  initialValue: viewModel.contact.email,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: viewModel.setEmail,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                GroupSelector(
                  selectedGroups: viewModel.contact.getGroups(),
                  onSelectGroups: (List<Group> groups) => viewModel
                      .setGroups(groups.map((group) => group.id).toList()),
                ),
                TextFormField(
                  initialValue: viewModel.contact.relationship,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  onChanged: viewModel.setRelationship,
                  decoration: const InputDecoration(labelText: "Relationship"),
                ),
                TextFormField(
                  initialValue: viewModel.contact.note,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: viewModel.setNote,
                  decoration: const InputDecoration(labelText: "Note"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _save(context, viewModel),
                  child: const Text("Save"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _save(BuildContext context, ContactAddEditViewModel viewModel) {
    final Contact? contact = viewModel.saveContact();
    if (contact != null) {
      Navigator.of(context).pop();
      if (!viewModel.isUpdate) {
        context.pushNamed(
          AppRoute.contactDetail.name,
          extra: contact.id,
        );
      }
    }
  }
}

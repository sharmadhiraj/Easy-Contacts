import 'package:easy_contacts/app/locator.dart';
import 'package:easy_contacts/models/contact.dart';
import 'package:easy_contacts/utils/common.dart';
import 'package:easy_contacts/utils/toast.dart';
import 'package:easy_contacts/viewmodels/contacts_viewmodel.dart';
import 'package:flutter/material.dart';

class AddContactBottomSheet extends StatefulWidget {
  const AddContactBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddContactBottomSheet> createState() => _AddContactBottomSheetState();

  static void show(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) => const AddContactBottomSheet(),
    );
  }
}

class _AddContactBottomSheetState extends State<AddContactBottomSheet> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _nickNameController.dispose();
    _emailController.dispose();
    _noteController.dispose();
    _relationshipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20)
            .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom + 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            const Center(
              child: Text(
                "Add New Contact",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(),
            TextFormField(
              controller: _firstNameController,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: "First Name"),
            ),
            TextFormField(
              controller: _lastNameController,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: "Last Name"),
            ),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: "Phone Number"),
            ),
            TextFormField(
              controller: _nickNameController,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: "Nick Name"),
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextFormField(
              controller: _noteController,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(labelText: "Note"),
            ),
            TextFormField(
              controller: _relationshipController,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: "Relationship"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _saveContact(context),
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }

  void _saveContact(BuildContext context) {
    if (_validateForm(context)) {
      locator<ContactScreenViewModel>().newContact(
        Contact(
          id: CommonUtil.generateRandomId(),
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          phoneNo: _phoneController.text,
          nickName: _nickNameController.text,
          email: _emailController.text,
          groups: [],
          note: _noteController.text,
          relationship: _relationshipController.text,
        ),
      );
      Navigator.pop(context);
    }
  }

  bool _validateForm(BuildContext context) {
    if (_firstNameController.text.isEmpty) {
      ToastUtil.showError(message: "Please provide first name!");
      return false;
    } else if (_phoneController.text.isEmpty) {
      ToastUtil.showError(message: "Please provide phone number!");
      return false;
    }
    return true;
  }
}

import 'package:easy_contacts/utils/toast.dart';
import 'package:flutter/material.dart';

class AddContactBottomSheet extends StatelessWidget {
  AddContactBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) => AddContactBottomSheet(),
    );
  }

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();

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
              decoration: const InputDecoration(labelText: "First Name"),
            ),
            TextFormField(
              controller: _lastNameController,
              keyboardType: TextInputType.name,
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
              decoration: const InputDecoration(labelText: "Note"),
            ),
            TextFormField(
              controller: _relationshipController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: "Relationship"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_validateForm(context)) {
                  // Handle saving the contact data here
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
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

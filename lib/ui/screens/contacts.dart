import 'package:easy_contacts/ui/widgets/add_contact.dart';
import 'package:easy_contacts/utils/constant.dart';
import 'package:flutter/material.dart';

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
    return Container();
  }
}

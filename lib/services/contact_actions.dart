import 'package:easy_contacts/app/locator.dart';
import 'package:easy_contacts/app/route.dart';
import 'package:easy_contacts/models/contact.dart';
import 'package:easy_contacts/ui/widgets/add_edit_contact.dart';
import 'package:easy_contacts/utils/toast.dart';
import 'package:easy_contacts/view_models/contacts.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ContactActions {
  static void copyPhoneNumber(String phoneNo) {
    Clipboard.setData(ClipboardData(text: phoneNo));
    ToastUtil.showInfo(message: "Phone number copied to clipboard.");
  }

  static void editContact(BuildContext context, Contact contact) {
    AddEditContactWidget.show(
      context: context,
      contact: contact,
    );
  }

  static void deleteContact(BuildContext context, Contact contact) {
    locator<ContactsViewModel>().removeContact(contact.id);
    context.goNamed(AppRoute.contacts.name);
    ToastUtil.showInfo(
      message: "Contact ${contact.firstName} deleted successfully.",
    );
  }
}

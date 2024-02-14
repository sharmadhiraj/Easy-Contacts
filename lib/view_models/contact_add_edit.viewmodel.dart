import 'package:easy_contacts/app/locator.dart';
import 'package:easy_contacts/models/contact.dart';
import 'package:easy_contacts/utils/toast.dart';
import 'package:easy_contacts/view_models/contacts.viewmodel.dart';
import 'package:stacked/stacked.dart';

class ContactAddEditViewModel extends BaseViewModel {
  late Contact contact;
  bool isUpdate = false;

  ContactAddEditViewModel({Contact? contact}) {
    isUpdate = contact != null;
    this.contact = contact ?? Contact.empty();
  }

  void setFirstName(String firstName) => contact.firstName = firstName;

  void setLastName(String lastName) => contact.lastName = lastName;

  void setPhoneNo(String phoneNo) => contact.phoneNo = phoneNo;

  void setNickName(String nickName) => contact.nickName = nickName;

  void setEmail(String email) => contact.email = email;

  void setGroups(List<String> groups) => contact.groups = groups;

  void setRelationship(String relationship) =>
      contact.relationship = relationship;

  void setNote(String note) => contact.note = note;

  Contact? saveContact() {
    if (_validateForm()) {
      if (isUpdate) {
        locator<ContactsViewModel>().updateContact(contact);
      } else {
        locator<ContactsViewModel>().newContact(contact);
      }
      return contact;
    }
    return null;
  }

  bool _validateForm() {
    if (contact.firstName.isEmpty) {
      ToastUtil.showError(message: "Please provide first name!");
      return false;
    } else if (contact.phoneNo.isEmpty) {
      ToastUtil.showError(message: "Please provide phone number!");
      return false;
    }
    return true;
  }
}

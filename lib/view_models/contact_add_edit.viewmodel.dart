import 'package:easy_contacts/models/contact.dart';
import 'package:stacked/stacked.dart';

class ContactAddEditViewModel extends BaseViewModel {
  late Contact contact;

  ContactAddEditViewModel({Contact? contact}) {
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
}

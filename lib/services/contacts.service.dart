import 'package:easy_contacts/models/contact.dart';
import 'package:easy_contacts/services/base.service.dart';
import 'package:easy_contacts/utils/constant.dart';

class ContactsService extends BaseService<Contact> {
  ContactsService() : super();

  @override
  String getHiveKeyName() => Constant.contactsHiveKeyName;
}

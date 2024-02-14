import 'package:easy_contacts/app/locator.dart';
import 'package:easy_contacts/models/base.dart';
import 'package:easy_contacts/services/groups.service.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Contact extends BaseModel {
  String firstName;
  String lastName;
  String phoneNo;
  String nickName;
  String email;
  List<String> groups;
  String note;
  String relationship;

  Contact({
    required super.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNo,
    required this.nickName,
    required this.email,
    required this.groups,
    required this.note,
    required this.relationship,
  });

  String getFullName() {
    return "$firstName $lastName".trim();
  }

  String getAvatar() {
    return firstName.isEmpty ? " " : firstName[0].toUpperCase();
  }

  String getGroups() {
    return locator<GroupsService>()
        .getGroupByIds(groups)
        .map((group) => group.name)
        .join(", ");
  }

  factory Contact.empty() {
    return Contact(
      id: "",
      firstName: "",
      lastName: "",
      phoneNo: "",
      nickName: "",
      email: "",
      groups: [],
      note: "",
      relationship: "",
    );
  }
}

class ContactAdapter extends TypeAdapter<Contact> {
  @override
  final int typeId = 1;

  @override
  Contact read(BinaryReader reader) {
    return Contact(
      id: reader.readString(),
      firstName: reader.readString(),
      lastName: reader.readString(),
      phoneNo: reader.readString(),
      nickName: reader.readString(),
      email: reader.readString(),
      groups: List<String>.from(reader.readList()),
      note: reader.readString(),
      relationship: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Contact obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.firstName);
    writer.writeString(obj.lastName);
    writer.writeString(obj.phoneNo);
    writer.writeString(obj.nickName);
    writer.writeString(obj.email);
    writer.writeList(obj.groups);
    writer.writeString(obj.note);
    writer.writeString(obj.relationship);
  }
}

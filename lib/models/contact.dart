class Contact {
  final String id;
  String firstName;
  String lastName;
  String phoneNo;
  String nickName;
  String email;
  List<String> groups;
  String note;
  String relationship;

  Contact({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNo,
    required this.nickName,
    required this.email,
    required this.groups,
    required this.note,
    required this.relationship,
  });
}

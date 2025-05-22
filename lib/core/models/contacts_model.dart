class ContactsModel {
  final String contactName;
  final List<String> contactNumber;
  final String? groupId;
  final String contactId;

  ContactsModel({
    required this.contactName,
    required this.contactNumber,
    this.groupId,
    required this.contactId,
  });
  factory ContactsModel.fromMap(Map<String, dynamic> map) {
    return ContactsModel(
      contactName: map['contactName'],
      contactId: map['contactId'],
      contactNumber: List<String>.from(map['contactNumber']),
      groupId: map['groupId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'contactName': contactName,
      'contactId': contactId,
      'contactNumber': contactNumber,
      'groupId': groupId,
    };
  }
}

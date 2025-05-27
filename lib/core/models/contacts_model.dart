import 'package:json_annotation/json_annotation.dart';

part 'contacts_model.g.dart';

@JsonSerializable()
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

  factory ContactsModel.fromMap(Map<String, dynamic> map) =>
      _$ContactsModelFromJson(map);

  Map<String, dynamic> toMap() => _$ContactsModelToJson(this);
}

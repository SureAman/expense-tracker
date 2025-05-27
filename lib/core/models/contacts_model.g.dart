// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactsModel _$ContactsModelFromJson(Map<String, dynamic> json) =>
    ContactsModel(
      contactName: json['contactName'] as String,
      contactNumber:
          (json['contactNumber'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      groupId: json['groupId'] as String?,
      contactId: json['contactId'] as String,
    );

Map<String, dynamic> _$ContactsModelToJson(ContactsModel instance) =>
    <String, dynamic>{
      'contactName': instance.contactName,
      'contactNumber': instance.contactNumber,
      'groupId': instance.groupId,
      'contactId': instance.contactId,
    };

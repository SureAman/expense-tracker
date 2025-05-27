// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseModel _$ExpenseModelFromJson(Map<String, dynamic> json) => ExpenseModel(
  expenseName: json['expenseName'] as String,
  id: json['id'] as String,
  expenseAmount: (json['expenseAmount'] as num).toDouble(),
  groupId: json['groupId'] as String,
  contactModel:
      (json['contactModel'] as List<dynamic>?)
          ?.map((e) => ContactsModel.fromMap(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$ExpenseModelToJson(ExpenseModel instance) =>
    <String, dynamic>{
      'expenseName': instance.expenseName,
      'id': instance.id,
      'expenseAmount': instance.expenseAmount,
      'groupId': instance.groupId,
      'contactModel': instance.contactModel?.map((e) => e.toMap()).toList(),
    };

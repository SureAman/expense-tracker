import 'package:expense_tracker/core/models/contacts_model.dart';

class ExpenseModel {
  final String expenseName;
  final String id;
  final double expenseAmount;
  final String groupId;
  final List<ContactsModel>? contactModel;

  ExpenseModel({
    required this.expenseName,
    required this.id,
    required this.expenseAmount,
    required this.groupId,
    this.contactModel,
  });

  ExpenseModel copyWith({
    String? expenseName,
    String? id,
    double? expenseAmount,
    String? groupId,
    List<ContactsModel>? contactModel,
  }) {
    return ExpenseModel(
      expenseName: expenseName ?? this.expenseName,
      id: id ?? this.id,
      expenseAmount: expenseAmount ?? this.expenseAmount,
      groupId: groupId ?? this.groupId,
      contactModel: contactModel ?? this.contactModel,
    );
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      expenseName: map['expenseName'],
      id: map['id'],
      expenseAmount: map['expenseAmount'],
      groupId: map['groupId'],
      contactModel:
          map['contactModel'] != null
              ? List<ContactsModel>.from(
                (map['contactModel'] as List).map(
                  (e) => ContactsModel.fromMap(e),
                ),
              )
              : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'expenseName': expenseName,
      'id': id,
      'expenseAmount': expenseAmount,
      'groupId': groupId,
      'contactModel': contactModel?.map((e) => e.toMap()).toList(),
    };
  }
}

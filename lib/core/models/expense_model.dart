class ExpenseModel {
  final String expenseName;
  final String id;
  final double expenseAmount;
  final int groupId; // NEW FIELD

  ExpenseModel({
    required this.expenseName,
    required this.id,
    required this.expenseAmount,
    required this.groupId,
  });

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      expenseName: map['expenseName'],
      id: map['id'],
      expenseAmount: map['expenseAmount'],
      groupId: map['groupId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'expenseName': expenseName,
      'id': id,
      'expenseAmount': expenseAmount,
      'groupId': groupId,
    };
  }
}

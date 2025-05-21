class ExpenseModel {
  final String expenseName;
  final String id;
  final double expenseAmount;

  ExpenseModel({
    required this.expenseName,
    required this.id,
    required this.expenseAmount,
  });

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      expenseName: map['expenseName'],
      id: map['id'],
      expenseAmount: map['expenseAmount'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'expenseName': expenseName,
      'id': id,
      'expenseAmount': expenseAmount,
    };
  }
}

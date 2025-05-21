class DummyExpenseModel {
  final String expenseName;
  final String id; // Unique ID for each expense
  final double expenseAmount;

  // Constructor
  DummyExpenseModel({
    required this.expenseName,
    required this.id,
    required this.expenseAmount,
  });

  // Factory constructor to create DummyExpenseModel from a map (useful for JSON parsing)
  factory DummyExpenseModel.fromMap(Map<String, dynamic> map) {
    return DummyExpenseModel(
      expenseName: map['expenseName'],
      id: map['id'],
      expenseAmount: map['expenseAmount'],
    );
  }

  // Convert the DummyExpenseModel to a map (useful for storing in databases, or sending data to a server)
  Map<String, dynamic> toMap() {
    return {
      'expenseName': expenseName,
      'id': id,
      'expenseAmount': expenseAmount,
    };
  }
}

List<DummyExpenseModel> generateDummyExpenses() {
  return [
    DummyExpenseModel(expenseName: 'Groceries', id: '1', expenseAmount: 150.75),
    DummyExpenseModel(
      expenseName: 'Electricity Bill',
      id: '2',
      expenseAmount: 100.25,
    ),
    DummyExpenseModel(
      expenseName: 'Internet Subscription',
      id: '3',
      expenseAmount: 50.00,
    ),
    DummyExpenseModel(expenseName: 'Coffee', id: '4', expenseAmount: 5.75),
    DummyExpenseModel(
      expenseName: 'Movie Tickets',
      id: '5',
      expenseAmount: 30.00,
    ),
    DummyExpenseModel(expenseName: 'Gas', id: '6', expenseAmount: 40.50),
    DummyExpenseModel(expenseName: 'Dining Out', id: '7', expenseAmount: 80.90),
    DummyExpenseModel(
      expenseName: 'Fitness Membership',
      id: '8',
      expenseAmount: 60.00,
    ),
    DummyExpenseModel(expenseName: 'Books', id: '9', expenseAmount: 20.45),
    DummyExpenseModel(
      expenseName: 'Phone Bill',
      id: '10',
      expenseAmount: 55.90,
    ),
  ];
}

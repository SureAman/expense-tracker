import 'package:expense_tracker/core/database/shared_preferences_manager.dart';
import 'package:expense_tracker/core/models/expense_model.dart';

abstract class ExpenseRepository {
  Future<List<ExpenseModel>> fetchExpenses();
}

class ExpenseRepositoryImpl extends ExpenseRepository {
  @override
  Future<List<ExpenseModel>> fetchExpenses() async {
    List<ExpenseModel> expenses = [];
    await Future.delayed(const Duration(seconds: 2), () async {
      expenses = await SharedPreferencesManager.getExpenses();
    });

    return expenses;
  }
}

import 'package:expense_tracker/core/database/shared_preferences_manager.dart';
import 'package:expense_tracker/core/models/contacts_model.dart';
import 'package:expense_tracker/core/models/expense_model.dart';

abstract class AddExpenseRepo {
  Future<bool> addExpenseRepository(ExpenseModel model);
  Future<List<ContactsModel>> fetchContacts();
}

class AddExpenseRepositoryImpl implements AddExpenseRepo {
  @override
  Future<bool> addExpenseRepository(ExpenseModel model) async {
    await Future.delayed(const Duration(seconds: 2), () {
      SharedPreferencesManager.addExpense(model);
    });
    return true;
  }

  @override
  Future<List<ContactsModel>> fetchContacts() async {
    List<ContactsModel> contacts = [];
    await Future.delayed(const Duration(seconds: 2), () async {
      contacts = await SharedPreferencesManager.getContacts();
    });
    return contacts;
  }
}

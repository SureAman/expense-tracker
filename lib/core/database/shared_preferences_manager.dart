import 'dart:convert';
import 'package:expense_tracker/core/models/contacts_model.dart';
import 'package:expense_tracker/core/models/expense_model.dart';
import 'package:expense_tracker/core/models/group_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static const String _groupListKey = 'GROUP_LIST';
  static const String _expenseListKey = 'EXPENSE_LIST';
  static const String _contactListKey = "CONTACT_LIST";
  static const String _nameKey = "NAME_KEY";
  static const String _numberKey = "NUMBER_KEY";
  static SharedPreferences? sharedPreferences;

  static Future<SharedPreferences> getInstance() async {
    return sharedPreferences ??= await SharedPreferences.getInstance();
  }

  // Saving the name and number
  static Future<void> saveNameAndNumber(String name, String number) async {
    final prefs = await getInstance();
    prefs.setString(_nameKey, name);
    prefs.setString(_numberKey, number);
  }

  //Getting the name
  static Future<String?> getName() async {
    final prefs = await getInstance();
    final name = prefs.getString(_nameKey);
    return name;
  }

  //Getting the number
  static Future<String?> getNumber() async {
    final prefs = await getInstance();
    final number = prefs.getString(_numberKey);
    return number;
  }

  /// Save list of groups
  static Future<void> saveGroups(List<GroupModel> groups) async {
    final prefs = await getInstance();
    final groupList = groups.map((g) => g.toMap()).toList();
    prefs.setString(_groupListKey, jsonEncode(groupList));
  }

  /// Get list of groups
  static Future<List<GroupModel>> getGroups() async {
    final prefs = await getInstance();
    final jsonString = prefs.getString(_groupListKey);
    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      return decoded.map((e) => GroupModel.fromMap(e)).toList();
    }
    return [];
  }

  /// Save list of expenses
  static Future<void> saveExpenses(List<ExpenseModel> expenses) async {
    final prefs = await getInstance();
    final expenseList = expenses.map((e) => e.toMap()).toList();
    prefs.setString(_expenseListKey, jsonEncode(expenseList));
  }

  /// Get list of expenses
  static Future<List<ExpenseModel>> getExpenses() async {
    final prefs = await getInstance();
    final jsonString = prefs.getString(_expenseListKey);
    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      return decoded.map((e) => ExpenseModel.fromMap(e)).toList();
    }
    return [];
  }

  static Future<void> saveContacts(List<ContactsModel> groups) async {
    final prefs = await getInstance();
    final contactsList = groups.map((g) => g.toMap()).toList();
    prefs.setString(_contactListKey, jsonEncode(contactsList));
  }

  static Future<List<ContactsModel>> getContacts() async {
    final prefs = await getInstance();
    final jsonString = prefs.getString(_contactListKey);
    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      return decoded.map((e) => ContactsModel.fromMap(e)).toList();
    }
    return [];
  }

  /// Append a single group to the stored list
  static Future<void> addGroup(GroupModel group) async {
    final groups = await getGroups();
    groups.add(group);
    await saveGroups(groups);
  }

  /// Append a single expense to the stored list
  static Future<void> addExpense(ExpenseModel expense) async {
    final expenses = await getExpenses();
    expenses.add(expense);
    await saveExpenses(expenses);
  }

  //Append a single contacts in stored list
  static Future<void> addContacts(List<ContactsModel> model) async {
    final contact = await getContacts();
    contact.addAll(model);
    await saveContacts(contact);
  }
}

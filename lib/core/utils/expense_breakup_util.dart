import 'package:expense_tracker/core/models/expense_model.dart';

class ExpenseBreakupUtil {
  static Map<String, double> calculateExpenseSplit(ExpenseModel model) {
    final contacts = model.contactModel ?? [];
    final bool isMyselfIncluded = contacts.any(
      (c) => c.contactId.trim().toLowerCase() == 'myself',
    );

    final filteredContacts =
        contacts.where((c) => c.contactId != 'myself').toList();

    final int splitCount =
        isMyselfIncluded ? contacts.length : filteredContacts.length;
    if (splitCount == 0) return {};

    final double perPersonAmount = model.expenseAmount / splitCount;

    return {
      for (var contact in filteredContacts)
        contact.contactName: perPersonAmount,
    };
  }

  static double calculateTotalGettingBack(Map<String, double> splitMap) {
    return splitMap.values.fold(0.0, (a, b) => a + b);
  }
}

import 'package:expense_tracker/core/constants/dummy_expense_model.dart';
import 'package:expense_tracker/core/constants/icons.dart';
import 'package:expense_tracker/core/constants/names.dart';
import 'package:expense_tracker/core/styles/text_styles.dart';
import 'package:expense_tracker/core/widgets/common_app_bar.dart';
import 'package:expense_tracker/core/widgets/common_elevated_button.dart';
import 'package:expense_tracker/feature/add_expense/screen/add_expense_screen.dart';
import 'package:flutter/material.dart';

class ExpenseDetailsScreen extends StatelessWidget {
  const ExpenseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(
        name: NameConstants.expenseDetails,
        isCenterTitle: true,
        isBold: true,
        backArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: _expenseList()),
            const SizedBox(height: 12),
          ],
        ),
      ),
      floatingActionButton: CommonElevatedButton(
        buttonText: NameConstants.addExpense,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddExpenseScreen()),
          );
        },
        icon: IconConstants.addIcon,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _expenseList() {
    final expenseList = generateDummyExpenses();
    return ListView.builder(
      itemCount: expenseList.length,
      itemBuilder: (_, index) {
        final eachExpense = expenseList[index];
        return _eachExpenseDetails(eachExpense);
      },
    );
  }

  Widget _eachExpenseDetails(DummyExpenseModel eachExpense) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
        child: ListTile(
          title: Text(
            eachExpense.expenseName,
            style: CommonTextStyles.boldTextStyle(),
          ),
          trailing: Text(
            "${eachExpense.expenseAmount} Rs.",
            style: CommonTextStyles.customTextStyle(
              textColor: Colors.redAccent,
            ),
          ),
        ),
      ),
    );
  }
}

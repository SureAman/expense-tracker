import 'package:expense_tracker/core/models/expense_model.dart';
import 'package:expense_tracker/core/styles/text_styles.dart';
import 'package:expense_tracker/core/utils/expense_breakup_util.dart';
import 'package:expense_tracker/core/widgets/common_app_bar.dart';
import 'package:flutter/material.dart';

class ExpenseBreakupScreen extends StatelessWidget {
  final ExpenseModel model;
  const ExpenseBreakupScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final splitMap = ExpenseBreakupUtil.calculateExpenseSplit(model);
    final totalGettingBack = ExpenseBreakupUtil.calculateTotalGettingBack(
      splitMap,
    );

    return Scaffold(
      appBar: _commonAppBar(),
      body: _mainBody(totalGettingBack, splitMap),
    );
  }

  CommonAppBar _commonAppBar() {
    return const CommonAppBar(
      name: "Expense Breakup",
      isCenterTitle: true,
      isBold: true,
      backArrow: true,
    );
  }

  Padding _mainBody(double totalGettingBack, Map<String, double> splitMap) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardMoneyGettingBack(totalGettingBack),
          const SizedBox(height: 20),
          Text("From", style: CommonTextStyles.boldTextStyle()),
          const SizedBox(height: 8),
          Expanded(child: _listViewMoneySplitPersons(splitMap)),
        ],
      ),
    );
  }

  ListView _listViewMoneySplitPersons(Map<String, double> splitMap) {
    return ListView.builder(
      itemCount: splitMap.length,
      itemBuilder: (context, index) {
        final name = splitMap.keys.elementAt(index);
        final amount = splitMap[name]!;
        return Card(
          child: ListTile(
            title: Text(name),
            trailing: Text(
              "₹${amount.toStringAsFixed(2)}",
              style: CommonTextStyles.boldTextStyle(),
            ),
          ),
        );
      },
    );
  }

  Card _cardMoneyGettingBack(double totalGettingBack) {
    return Card(
      color: Colors.green[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.green,
          child: Text("You", style: TextStyle(color: Colors.white)),
        ),
        title: const Text("You're getting back"),
        trailing: Text(
          "₹${totalGettingBack.toStringAsFixed(2)}",

          style: CommonTextStyles.customTextStyle(
            fontSize: 18,
            textColor: Colors.green.shade800,
          ),
        ),
      ),
    );
  }
}

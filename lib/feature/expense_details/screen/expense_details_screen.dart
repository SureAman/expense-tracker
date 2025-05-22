import 'package:expense_tracker/core/constants/icons.dart';
import 'package:expense_tracker/core/constants/names.dart';
import 'package:expense_tracker/core/models/expense_model.dart';
import 'package:expense_tracker/core/route/route_names.dart';
import 'package:expense_tracker/core/styles/text_styles.dart';
import 'package:expense_tracker/core/widgets/common_app_bar.dart';
import 'package:expense_tracker/core/widgets/common_elevated_button.dart';
import 'package:expense_tracker/feature/expense_details/bloc/expense_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseDetailsScreen extends StatelessWidget {
  const ExpenseDetailsScreen({super.key, required this.groupId});
  final String groupId;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExpenseDetailsBloc>().add(
        FetchInitialExpenseEvent(groupId: groupId),
      );
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: _buildBody(),
      floatingActionButton: _elevatedButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  CommonElevatedButton _elevatedButton(BuildContext context) {
    return CommonElevatedButton(
      buttonText: NameConstants.addExpense,
      onPressed: () {
        Navigator.pushNamed(context, RouteNames.addexpense);
      },
      icon: IconConstants.addIcon,
    );
  }

  Padding _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Expanded(child: _blocBuilder()), const SizedBox(height: 12)],
      ),
    );
  }

  CommonAppBar _appBar() {
    return const CommonAppBar(
      name: NameConstants.expenseDetails,
      isCenterTitle: true,
      isBold: true,
      backArrow: true,
    );
  }

  BlocBuilder<ExpenseDetailsBloc, ExpenseDetailsState> _blocBuilder() {
    //final expenseList = generateDummyExpenses();
    return BlocBuilder<ExpenseDetailsBloc, ExpenseDetailsState>(
      builder: (context, state) {
        if (state.status == ExpenseDetailsStatus.loading) {
          print("ExpenseLoading");
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == ExpenseDetailsStatus.loaded) {
          print("ExpenseLoaded");
          final expenseListModel = state.model;
          if (expenseListModel.isEmpty) {
            return Center(
              child: Text(
                "No Expenses Found",
                style: CommonTextStyles.semiBoldTextStyle(),
              ),
            );
          } else {
            return _expenseList(expenseListModel);
          }
        }
        return const SizedBox();
      },
    );
  }

  ListView _expenseList(List<ExpenseModel> expenseListModel) {
    return ListView.builder(
      itemCount: expenseListModel.length,
      itemBuilder: (_, index) {
        final eachExpense = expenseListModel[index];
        return _eachExpenseDetails(eachExpense);
      },
    );
  }

  Widget _eachExpenseDetails(ExpenseModel eachExpense) {
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

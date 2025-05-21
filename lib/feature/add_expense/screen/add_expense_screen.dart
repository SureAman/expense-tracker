import 'package:expense_tracker/core/constants/icons.dart';
import 'package:expense_tracker/core/constants/names.dart';
import 'package:expense_tracker/core/widgets/common_app_bar.dart';
import 'package:expense_tracker/core/widgets/common_elevated_button.dart';
import 'package:expense_tracker/core/widgets/common_text_form_field.dart';
import 'package:flutter/material.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: const CommonAppBar(
        name: NameConstants.addExpense,
        isCenterTitle: true,
        backArrow: true,
        isBold: true,
      ),
      body: _buildForm(),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formkey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Center(
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 12),
                  CommonTextFormField(
                    controller: _descriptionController,
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty) {}
                      } else {}
                      return null;
                    },
                    labelText: NameConstants.description,
                    icon: IconConstants.descriptionIcon,
                  ),
                  const SizedBox(height: 16),
                  CommonTextFormField(
                    controller: _amountController,
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty) {}
                      } else {}
                      return null;
                    },
                    labelText: NameConstants.enterAmount,
                    type: TextInputType.number,
                    icon: IconConstants.ruppeeIcon,
                  ),
                  const SizedBox(height: 24),
                  CommonElevatedButton(
                    buttonText: NameConstants.add,
                    onPressed: () {},
                    icon: IconConstants.addIcon,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

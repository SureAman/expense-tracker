import 'package:expense_tracker/core/constants/icons.dart';
import 'package:expense_tracker/core/constants/names.dart';
import 'package:expense_tracker/core/utils/validation_utils.dart';
import 'package:expense_tracker/core/widgets/common_elevated_button.dart';
import 'package:expense_tracker/core/widgets/common_text_form_field.dart';
import 'package:flutter/material.dart';

class AddExpenseForm extends StatefulWidget {
  final TextEditingController descriptionController;
  final TextEditingController amountController;
  final GlobalKey<FormState> formKey;

  const AddExpenseForm({
    super.key,
    required this.descriptionController,
    required this.amountController,
    required this.formKey,
  });

  @override
  State<AddExpenseForm> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> with ValidationUtils {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                CommonTextFormField(
                  controller: widget.descriptionController,
                  validator: validateName,
                  labelText: NameConstants.description,
                  icon: IconConstants.descriptionIcon,
                ),
                const SizedBox(height: 16),
                CommonTextFormField(
                  controller: widget.amountController,
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'Value Cannot be empty';
                      }
                    } else {
                      return "Please enter amount";
                    }
                    return null;
                  },
                  labelText: NameConstants.enterAmount,
                  type: TextInputType.number,
                  icon: IconConstants.ruppeeIcon,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:expense_tracker/core/constants/icons.dart';
import 'package:expense_tracker/core/styles/input_border_style.dart';
import 'package:flutter/material.dart';

class CommonTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final TextInputType type;
  final String labelText;
  final Icon icon;

  const CommonTextFormField({
    super.key,
    required this.controller,
    required this.validator,
    this.type = TextInputType.name,
    required this.labelText,
    this.icon = IconConstants.personIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(labelText),
        icon: icon,
        enabledBorder: OutlineInputBorderStyle.outlineInputBorder(),
        disabledBorder: OutlineInputBorderStyle.outlineInputBorder(
          borderColor: Colors.grey.shade400,
          borderWidth: 0.5,
        ),
        errorBorder: OutlineInputBorderStyle.outlineInputBorder(
          borderColor: Colors.redAccent,
        ),
        focusedBorder: OutlineInputBorderStyle.outlineInputBorder(
          borderColor: Colors.blueAccent.shade700,
        ),
        focusedErrorBorder: OutlineInputBorderStyle.outlineInputBorder(
          borderColor: Colors.redAccent,
        ),
      ),
      keyboardType: type,
      validator: validator,
    );
  }
}

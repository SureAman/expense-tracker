import 'package:expense_tracker/core/constants/icons.dart';
import 'package:expense_tracker/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class CommonElevatedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Icon icon;
  const CommonElevatedButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.icon = IconConstants.signupIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(
        buttonText,
        style: CommonTextStyles.semiBoldTextStyle(textColor: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
    );
  }
}

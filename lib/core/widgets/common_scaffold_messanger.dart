import 'package:flutter/material.dart';

enum ErrorType { error, success, warning }

class CommonScaffoldMessenger {
  static void show({
    required BuildContext context,
    required String message,
    required ErrorType errorType,
  }) {
    Color backgroundColor;
    IconData iconData;
    Color iconColor = Colors.white;

    switch (errorType) {
      case ErrorType.error:
        backgroundColor = Colors.red;
        iconData = Icons.error;
        break;
      case ErrorType.success:
        backgroundColor = Colors.green;
        iconData = Icons.check_circle;
        break;
      case ErrorType.warning:
        backgroundColor = Colors.orange;
        iconData = Icons.warning;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(iconData, color: iconColor),
            const SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

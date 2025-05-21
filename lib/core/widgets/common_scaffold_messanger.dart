import 'package:flutter/material.dart';

enum ErrorType { error, success, warning }

class CommonScaffoldMessenger extends StatelessWidget {
  final String message;
  final ErrorType
  errorType; // Add this to determine the type of message (error, success, warning)

  const CommonScaffoldMessenger({
    super.key,
    required this.message,
    required this.errorType, // Add this parameter to pass the message type
  });

  @override
  Widget build(BuildContext context) {
    // Define the color and style for each type of message
    Color backgroundColor;
    IconData iconData;
    Color iconColor;

    switch (errorType) {
      case ErrorType.error:
        backgroundColor = Colors.red;
        iconData = Icons.error;
        iconColor = Colors.white;
        break;
      case ErrorType.success:
        backgroundColor = Colors.green;
        iconData = Icons.check_circle;
        iconColor = Colors.white;
        break;
      case ErrorType.warning:
        backgroundColor = Colors.orange;
        iconData = Icons.warning;
        iconColor = Colors.white;
        break;
    }

    // Display the message using ScaffoldMessenger
    return ScaffoldMessenger(
      child: SnackBar(
        content: Row(
          children: [
            Icon(iconData, color: iconColor),
            const SizedBox(width: 10),
            Expanded(child: Text(message)), // Display the message
          ],
        ),
        backgroundColor:
            backgroundColor, // Set background color based on the message type
      ),
    );
  }
}

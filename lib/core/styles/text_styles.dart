import 'package:flutter/material.dart';

class CommonTextStyles {
  static TextStyle boldTextStyle({Color textColor = Colors.black}) => TextStyle(
    color: textColor,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    letterSpacing: 0.1,
  );
  static TextStyle semiBoldTextStyle({Color textColor = Colors.black}) =>
      TextStyle(
        color: textColor,
        fontWeight: FontWeight.w500,
        fontSize: 14,
        letterSpacing: 0.1,
      );
  static TextStyle normalTextStyle({Color textColor = Colors.black}) =>
      TextStyle(
        color: textColor,
        fontWeight: FontWeight.w400,
        fontSize: 14,
        letterSpacing: 0.1,
      );

  static TextStyle customTextStyle({
    Color textColor = Colors.black,
    FontWeight fontWeight = FontWeight.w500,
    double letterSpacing = 0.1,
    double fontSize = 16,
  }) => TextStyle(
    color: textColor,
    fontWeight: FontWeight.w600,
    fontSize: fontSize,
    letterSpacing: letterSpacing,
  );
}

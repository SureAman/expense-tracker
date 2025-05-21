import 'package:flutter/material.dart';

class OutlineInputBorderStyle {
  static OutlineInputBorder outlineInputBorder({
    double radius = 4,
    Color borderColor = Colors.blueAccent,
    double gapInsideBorder = 6.0,
    double borderWidth = 1,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(width: borderWidth, color: borderColor),
      gapPadding: gapInsideBorder,
    );
  }
}

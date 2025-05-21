import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final bool isCenterTitle;
  final bool backArrow;
  final bool isBold;
  const CommonAppBar({
    super.key,
    required this.name,
    this.isCenterTitle = false,
    this.backArrow = false,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
        title: Text(
          name,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        centerTitle: isCenterTitle,
        automaticallyImplyLeading: backArrow,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55.0);
}

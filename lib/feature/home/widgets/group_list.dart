import 'package:expense_tracker/core/constants/icons.dart';
import 'package:expense_tracker/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class GroupList extends StatelessWidget {
  final String title;
  final int members;
  const GroupList({super.key, required this.title, required this.members});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconConstants.groupIcon,
      title: Text(title, style: CommonTextStyles.customTextStyle(fontSize: 20)),
      subtitle: Text(
        "$members members",
        style: CommonTextStyles.customTextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
      ),
    );
  }
}

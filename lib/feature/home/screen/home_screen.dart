import 'package:expense_tracker/core/constants/group_constants.dart';
import 'package:expense_tracker/core/constants/icons.dart';
import 'package:expense_tracker/core/constants/names.dart';
import 'package:expense_tracker/core/styles/text_styles.dart';
import 'package:expense_tracker/core/widgets/common_app_bar.dart';
import 'package:expense_tracker/core/widgets/common_elevated_button.dart';
import 'package:expense_tracker/feature/create_group/screen/create_group_screen.dart';
import 'package:expense_tracker/feature/home/widgets/group_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(
        name: NameConstants.home,
        isCenterTitle: true,
        isBold: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "${NameConstants.name} : Aman Sinha",
                style: CommonTextStyles.customTextStyle(fontSize: 18),
              ),
            ),
            const Divider(),
            Expanded(child: _groupList()),
            const Divider(),
            _elevatedButton(context),
          ],
        ),
      ),
    );
  }

  Widget _groupList() {
    return ListView.builder(
      itemCount: groupDetails.length,
      key: UniqueKey(),
      itemBuilder: (_, index) {
        return GroupList(
          title: groupDetails[index]['name'].toString(),
          members: groupDetails[index]['members'] as int,
        );
      },
    );
  }

  Widget _elevatedButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: CommonElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateGroupScreen(),
              ),
            );
          },
          icon: IconConstants.groupAddIcon,
          buttonText: NameConstants.createGroup,
        ),
      ),
    );
  }
}

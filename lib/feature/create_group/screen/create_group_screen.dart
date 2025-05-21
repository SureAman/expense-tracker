import 'package:expense_tracker/core/constants/icons.dart';
import 'package:expense_tracker/core/constants/names.dart';
import 'package:expense_tracker/core/widgets/common_app_bar.dart';
import 'package:expense_tracker/core/widgets/common_elevated_button.dart';
import 'package:expense_tracker/core/widgets/common_scaffold_messanger.dart';
import 'package:expense_tracker/core/widgets/common_text_form_field.dart';
import 'package:expense_tracker/feature/create_group/widgets/contact_list_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final TextEditingController _groupNameCotroller = TextEditingController();
  final GlobalKey<FormState> _state = GlobalKey();
  Set<int> selectedIndices = <int>{};

  List<Contact>? _contacts;
  bool _permissionDenied = false;

  @override
  void initState() {
    _fetchContacts();
    super.initState();
  }

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts(withProperties: true);
      setState(() => _contacts = contacts);
    }
  }

  @override
  void dispose() {
    _groupNameCotroller.dispose();
    _state.currentState?.dispose();
    selectedIndices = {};
    _permissionDenied = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: const CommonAppBar(
        name: NameConstants.createGroup,
        isCenterTitle: true,
        backArrow: true,
        isBold: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _groupTextField(),
            const Divider(),
            Expanded(child: _contactList()),
            const Divider(),
            _createGroupButton(),
          ],
        ),
      ),
    );
  }

  Widget _groupTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Form(
        key: _state,
        child: CommonTextFormField(
          controller: _groupNameCotroller,
          validator: (value) {
            if (value != null) {
              if (value.isEmpty) {
                return NameConstants.pleaseEnterValidGroupName;
              }
              return null;
            } else {
              return NameConstants.groupNameIsRequired;
            }
          },
          labelText: "Group Name",
        ),
      ),
    );
  }

  Widget _createGroupButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Center(
        child: CommonElevatedButton(
          buttonText: NameConstants.create,
          icon: IconConstants.addIcon,
          onPressed: () {
            if (_state.currentState!.validate()) {
              if (selectedIndices.isEmpty) {
                const CommonScaffoldMessenger(
                  errorType: ErrorType.error,
                  message: NameConstants.pleaseSelectContact,
                );
              }
            } else {}
          },
        ),
      ),
    );
  }

  Widget _contactList() {
    if (_permissionDenied) {
      return const Center(child: Text(NameConstants.permissionDenied));
    }
    if (_contacts == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      key: UniqueKey(),
      itemCount: _contacts!.length,
      itemBuilder: (_, index) {
        final eachContact = _contacts![index];
        return ContactListDetails(contact: eachContact, index: index);
      },
    );
  }
}

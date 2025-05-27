import 'package:expense_tracker/core/constants/icons.dart';
import 'package:expense_tracker/core/constants/names.dart';
import 'package:expense_tracker/core/widgets/common_app_bar.dart';
import 'package:expense_tracker/core/widgets/common_elevated_button.dart';
import 'package:expense_tracker/core/widgets/common_scaffold_messanger.dart';
import 'package:expense_tracker/core/widgets/common_text_form_field.dart';
import 'package:expense_tracker/feature/create_group/bloc/bloc/create_group_bloc.dart';
import 'package:expense_tracker/feature/create_group/widgets/contact_list_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final TextEditingController _groupNameCotroller = TextEditingController();
  final GlobalKey<FormState> _state = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CreateGroupBloc>().add(FetchContactEvent());
    });
    super.initState();
  }

  @override
  void dispose() {
    _groupNameCotroller.dispose();
    _state.currentState?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: _appBar(),
      body: _blocConsumer(),
    );
  }

  CommonAppBar _appBar() {
    return const CommonAppBar(
      name: NameConstants.createGroup,
      isCenterTitle: true,
      backArrow: true,
      isBold: true,
    );
  }

  BlocConsumer<CreateGroupBloc, CreateGroupState> _blocConsumer() {
    return BlocConsumer<CreateGroupBloc, CreateGroupState>(
      buildWhen:
          (previous, current) =>
              current.status == CreateGroupStatus.loading ||
              current.status == CreateGroupStatus.success,
      builder: (context, state) {
        if (state.status == CreateGroupStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        return _buildUi();
      },
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (_, state) {
        if (state.status == CreateGroupStatus.error) {
          CommonScaffoldMessenger.show(
            context: context,
            message: NameConstants.pleaseSelectContact,
            errorType: ErrorType.warning,
          );
        } else if (state.status == CreateGroupStatus.success) {
          CommonScaffoldMessenger.show(
            context: context,
            message: NameConstants.groupCreatedSuccessfully,
            errorType: ErrorType.success,
          );
          Navigator.pop(context, true);
        }
      },
    );
  }

  Padding _buildUi() {
    return Padding(
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
              context.read<CreateGroupBloc>().add(
                CreateNewGroupEvent(groupName: _groupNameCotroller.text),
              );
            } else {}
          },
        ),
      ),
    );
  }

  Widget _contactList() {
    return BlocBuilder<CreateGroupBloc, CreateGroupState>(
      builder: (context, state) {
        if (state.isPermissionDenied) {
          return const Center(child: Text(NameConstants.permissionDenied));
        } else if (state.contacts.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.contacts.isNotEmpty) {
          return ListView.builder(
            itemCount: state.contacts.length,
            itemBuilder: (_, index) {
              final eachContact = state.contacts[index];
              return ContactListDetails(contact: eachContact, index: index);
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}

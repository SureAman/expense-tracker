import 'package:expense_tracker/feature/create_group/bloc/bloc/create_group_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactListDetails extends StatelessWidget {
  final Contact contact;
  final int index;

  const ContactListDetails({
    super.key,
    required this.contact,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contact.displayName),
      subtitle: ListView.builder(
        key: ValueKey(contact.id),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: contact.phones.length,
        itemBuilder: (_, index) {
          return _number(contact.phones[index]);
        },
      ),
      trailing: BlocBuilder<CreateGroupBloc, CreateGroupState>(
        builder: (context, state) {
          return Checkbox(
            key: ValueKey(contact.id),
            value: state.selectedIndices.contains(index),
            onChanged: (value) {
              _onCheckboxChanged(value, index, context);
            },
          );
        },
      ),
    );
  }

  void _onCheckboxChanged(bool? value, int index, BuildContext context) {
    context.read<CreateGroupBloc>().add(
      SelectedContactEvent(index: index, value: value),
    );
  }

  Widget _number(Phone phone) {
    return Text(phone.number);
  }
}

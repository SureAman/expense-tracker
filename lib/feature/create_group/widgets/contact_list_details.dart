import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactListDetails extends StatefulWidget {
  final Contact contact;
  final int index;

  const ContactListDetails({
    super.key,
    required this.contact,
    required this.index,
  });

  @override
  State<ContactListDetails> createState() => _ContactListDetailsState();
}

class _ContactListDetailsState extends State<ContactListDetails> {
  Set<int> selectedIndices = <int>{};

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.contact.displayName),
      subtitle: ListView.builder(
        key: ValueKey(widget.contact.id),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.contact.phones.length,
        itemBuilder: (_, index) {
          return _number(widget.contact.phones[index]);
        },
      ),
      trailing: Checkbox(
        key: ValueKey(widget.contact.id),
        value: selectedIndices.contains(widget.index),
        onChanged: (value) {
          _onCheckboxChanged(value, widget.index);
        },
      ),
    );
  }

  void _onCheckboxChanged(bool? value, int index) {
    setState(() {
      if (value == true) {
        selectedIndices.add(index); // Add index to set when selected
      } else {
        selectedIndices.remove(index); // Remove index from set when deselected
      }
    });
  }

  Widget _number(Phone phone) {
    return Text(phone.number);
  }
}

import 'package:expense_tracker/core/database/shared_preferences_manager.dart';
import 'package:expense_tracker/core/models/contacts_model.dart';
import 'package:expense_tracker/core/models/group_model.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

abstract class CreateGroupRepo {
  Future<void> addGroup(GroupModel model);
  Future<List<Contact>> fetchContacts();
  Future<void> addContacts(List<ContactsModel> model);
}

class CreateGroupRepoImpl implements CreateGroupRepo {
  @override
  Future<void> addGroup(GroupModel model) async {
    await Future.delayed(const Duration(seconds: 3), () {
      SharedPreferencesManager.addGroup(model);
    });
  }

  @override
  Future<List<Contact>> fetchContacts() async {
    List<Contact> contact = [];
    await Future.delayed(const Duration(seconds: 2), () async {
      contact = await FlutterContacts.getContacts(withProperties: true);
    });
    return contact;
  }

  @override
  Future<void> addContacts(List<ContactsModel> model) async {
    await Future.delayed(const Duration(seconds: 2), () async {
      await SharedPreferencesManager.addContacts(model);
    });
  }
}

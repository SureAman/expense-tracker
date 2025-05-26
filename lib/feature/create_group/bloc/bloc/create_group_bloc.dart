import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/core/constants/names.dart';
import 'package:expense_tracker/core/database/shared_preferences_manager.dart';
import 'package:expense_tracker/core/models/contacts_model.dart';
import 'package:expense_tracker/core/models/group_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

part 'create_group_event.dart';
part 'create_group_state.dart';

class CreateGroupBloc extends Bloc<CreateGroupEvent, CreateGroupState> {
  CreateGroupBloc() : super(const CreateGroupState()) {
    on<CreateNewGroupEvent>((event, emit) async {
      emit(state.copyWith(status: CreateGroupStatus.loading));

      print(state.selectedIndices);
      if (state.selectedIndices.isEmpty) {
        emit(state.copyWith(status: CreateGroupStatus.error));
        return;
      }

      print("Not Empty");

      List<ContactsModel> models = [];

      String id = "${event.groupName} ${UniqueKey()}}";
      for (var index in state.selectedIndices) {
        Contact contact = state.contacts.elementAt(index);
        models.add(
          ContactsModel(
            contactName: contact.displayName.toString(),
            contactNumber:
                contact.phones.map((number) => number.number).toList(),
            contactId: "${contact.name}",
            groupId: id,
          ),
        );
      }
      final memberCount = models.length;

      print("models $models");
      print("Member Count : ${memberCount + 1}");

      SharedPreferencesManager.addGroup(
        GroupModel(id: id, name: event.groupName, members: memberCount + 1),
      );
      SharedPreferencesManager.addContacts(models);

      emit(state.copyWith(status: CreateGroupStatus.loaded));
    });

    on<SelectedContactEvent>((event, emit) {
      final newSelectedIndices = {...state.selectedIndices};

      if (event.value == true) {
        newSelectedIndices.add(event.index);
      } else {
        newSelectedIndices.remove(event.index);
      }

      emit(state.copyWith(selectedIndices: newSelectedIndices));
    });

    on<FetchContactEvent>((event, emit) async {
      if (!await FlutterContacts.requestPermission(readonly: true)) {
        emit(state.copyWith(isPermissionDenied: true));
      } else {
        final contacts = await FlutterContacts.getContacts(
          withProperties: true,
        );
        emit(state.copyWith(contacts: contacts));
      }
    });
  }
}

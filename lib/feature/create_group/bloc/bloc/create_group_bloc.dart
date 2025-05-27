import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:expense_tracker/core/dependencies/dependencies.dart';
import 'package:expense_tracker/core/models/contacts_model.dart';
import 'package:expense_tracker/core/models/group_model.dart';
import 'package:expense_tracker/feature/create_group/repository/create_group_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

part 'create_group_event.dart';
part 'create_group_state.dart';

class CreateGroupBloc extends Bloc<CreateGroupEvent, CreateGroupState> {
  final CreateGroupRepoImpl createGroupRepoImpl = getIt<CreateGroupRepoImpl>();
  CreateGroupBloc() : super(const CreateGroupState()) {
    //For Creating New Group
    on<CreateNewGroupEvent>(_createNewGroupEvent);
    //For Selcting the Contacts inside the group
    on<SelectedContactEvent>(_selectContactEvent);
    //For Fetching the contact from mobile
    on<FetchContactEvent>(_fetchContactEvent);
    //Reseting the selectedindices
    on<ResetSelectedIndices>(_resetSelectedIndices);
  }

  void _createNewGroupEvent(
    CreateNewGroupEvent event,
    Emitter<CreateGroupState> emit,
  ) {
    emit(state.copyWith(status: CreateGroupStatus.loading));
    if (state.selectedIndices.isEmpty) {
      emit(state.copyWith(status: CreateGroupStatus.error));
      return;
    }

    List<ContactsModel> contactModels = [];

    String id = "${event.groupName} ${UniqueKey()}}";
    for (var index in state.selectedIndices) {
      Contact contact = state.contacts.elementAt(index);
      contactModels.add(
        ContactsModel(
          contactName: contact.displayName.toString(),
          contactNumber: contact.phones.map((number) => number.number).toList(),
          contactId: "${contact.name}",
          groupId: id,
        ),
      );
    }
    final memberCount = contactModels.length;

    final GroupModel groupModel = GroupModel(
      id: id,
      name: event.groupName,
      members: memberCount + 1,
    );

    createGroupRepoImpl.addGroup(groupModel);
    createGroupRepoImpl.addContacts(contactModels);

    emit(state.copyWith(status: CreateGroupStatus.success));
  }

  FutureOr<void> _selectContactEvent(
    SelectedContactEvent event,
    Emitter<CreateGroupState> emit,
  ) {
    final newSelectedIndices = {...state.selectedIndices};

    if (event.value == true) {
      newSelectedIndices.add(event.index);
    } else {
      newSelectedIndices.remove(event.index);
    }

    emit(state.copyWith(selectedIndices: newSelectedIndices));
  }

  FutureOr<void> _fetchContactEvent(
    FetchContactEvent event,
    Emitter<CreateGroupState> emit,
  ) async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      emit(state.copyWith(isPermissionDenied: true));
    } else {
      final contacts = await createGroupRepoImpl.fetchContacts();
      emit(state.copyWith(contacts: contacts));
    }
  }

  FutureOr<void> _resetSelectedIndices(
    ResetSelectedIndices event,
    Emitter<CreateGroupState> emit,
  ) {
    emit(state.copyWith(selectedIndices: {}));
  }
}

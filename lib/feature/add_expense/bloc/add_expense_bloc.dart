import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:expense_tracker/core/dependencies/dependencies.dart';
import 'package:expense_tracker/core/models/contacts_model.dart';
import 'package:expense_tracker/core/models/expense_model.dart';
import 'package:expense_tracker/feature/add_expense/repository/add_expense_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_expense_event.dart';
part 'add_expense_state.dart';

class AddExpenseBloc extends Bloc<AddExpenseInitialEvent, AddExpenseState> {
  final AddExpenseRepositoryImpl addExpenseRepoImpl =
      getIt<AddExpenseRepositoryImpl>();
  //final AddExpenseRepository repository;
  AddExpenseBloc() : super(const AddExpenseState()) {
    //For Adding the expense
    on<AddExpenseEvent>(_addExpenseEvent);
    //For Fetching the group specific contacts
    on<FetchContactsList>(_fetchContactList);
    //For Selecting the contacts which are needed to add for the specific expense
    on<SelectedContactEvent>(_selectedContactEvent);
  }

  FutureOr<void> _addExpenseEvent(
    AddExpenseEvent event,
    Emitter<AddExpenseState> emit,
  ) {
    emit(state.copyWith(status: AddExpenseStatus.loading));
    final List<ContactsModel> contactsModel = [];
    for (var index in state.selectedIndices) {
      ContactsModel eachContact = state.model.elementAt(index);
      contactsModel.add(eachContact);
    }
    ExpenseModel model = event.expenseModel.copyWith(
      contactModel: contactsModel,
    );
    addExpenseRepoImpl.addExpenseRepository(model);
    emit(state.copyWith(status: AddExpenseStatus.success));
  }

  FutureOr<void> _fetchContactList(
    FetchContactsList event,
    Emitter<AddExpenseState> emit,
  ) async {
    emit(state.copyWith(contactStatus: FetchContactsStatus.loading));
    final contacts = await addExpenseRepoImpl.fetchContacts();
    final filteredContactList =
        contacts
            .where((eachContact) => eachContact.groupId == event.groupId)
            .toList();

    filteredContactList.insert(
      0,
      ContactsModel(
        contactName: "Me",
        contactNumber: ["8318431689"],
        contactId: "myself",
      ),
    );

    emit(
      state.copyWith(
        contactStatus: FetchContactsStatus.success,
        model: filteredContactList,
      ),
    );
  }

  FutureOr<void> _selectedContactEvent(
    SelectedContactEvent event,
    Emitter<AddExpenseState> emit,
  ) {
    final newSelectedIndices = {...state.selectedIndices};

    if (event.value == true) {
      newSelectedIndices.add(event.index);
    } else {
      newSelectedIndices.remove(event.index);
    }

    emit(state.copyWith(selectedIndices: newSelectedIndices));
  }
}

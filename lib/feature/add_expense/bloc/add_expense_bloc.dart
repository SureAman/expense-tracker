import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:expense_tracker/core/database/shared_preferences_manager.dart';
import 'package:expense_tracker/core/models/contacts_model.dart';
import 'package:expense_tracker/core/models/expense_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_expense_event.dart';
part 'add_expense_state.dart';

class AddExpenseBloc extends Bloc<AddExpenseInitialEvent, AddExpenseState> {
  AddExpenseBloc() : super(const AddExpenseState()) {
    on<AddExpenseEvent>(_addExpenseEvent);
    on<FetchContactsList>(_fetchContactList);
    on<SelectedContactEvent>(_selectedContactEvent);
  }

  FutureOr<void> _addExpenseEvent(
    AddExpenseEvent event,
    Emitter<AddExpenseState> emit,
  ) {
    emit(state.copyWith(status: AddExpenseStatus.loading));
    final List<ContactsModel> model = [];
    for (var index in state.selectedIndices) {
      ContactsModel contactsModel = state.model.elementAt(index);
      model.add(contactsModel);
    }
    print(event.expenseModel.expenseName);
    SharedPreferencesManager.addExpense(
      event.expenseModel.copyWith(contactModel: model),
    );
    emit(state.copyWith(status: AddExpenseStatus.success));
  }

  FutureOr<void> _fetchContactList(
    FetchContactsList event,
    Emitter<AddExpenseState> emit,
  ) async {
    emit(state.copyWith(contactStatus: FetchContactsStatus.loading));
    final contacts = await SharedPreferencesManager.getContacts();
    for (var eachContact in contacts) {
      print(eachContact.groupId);
    }
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

    print(filteredContactList);
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

part of 'add_expense_bloc.dart';

sealed class AddExpenseInitialEvent extends Equatable {
  const AddExpenseInitialEvent();

  @override
  List<Object> get props => [];
}

class AddExpenseEvent extends AddExpenseInitialEvent {
  final ExpenseModel expenseModel;
  final List<ContactsModel> contactModel;
  const AddExpenseEvent({
    required this.expenseModel,
    required this.contactModel,
  });
}

class FetchContactsList extends AddExpenseInitialEvent {
  final String groupId;
  const FetchContactsList({required this.groupId});
}

class SelectedContactEvent extends AddExpenseInitialEvent {
  final bool? value;
  final int index;

  const SelectedContactEvent({required this.index, required this.value});
}

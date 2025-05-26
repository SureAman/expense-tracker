part of 'add_expense_bloc.dart';

enum AddExpenseStatus { initial, loading, success, error }

enum FetchContactsStatus { initial, loading, success, error }

class AddExpenseState extends Equatable {
  final AddExpenseStatus status;
  final FetchContactsStatus contactStatus;
  final List<ContactsModel> model;
  final Set<int> selectedIndices;

  const AddExpenseState({
    this.status = AddExpenseStatus.initial,
    this.contactStatus = FetchContactsStatus.initial,
    this.model = const [],
    this.selectedIndices = const <int>{},
  });
  AddExpenseState copyWith({
    AddExpenseStatus? status,
    FetchContactsStatus? contactStatus,
    List<ContactsModel>? model,
    Set<int>? selectedIndices,
  }) {
    return AddExpenseState(
      status: status ?? this.status,
      contactStatus: contactStatus ?? this.contactStatus,
      model: model ?? this.model,
      selectedIndices: selectedIndices ?? this.selectedIndices,
    );
  }

  @override
  List<Object> get props => [status, model, selectedIndices, contactStatus];
}

part of 'expense_details_bloc.dart';

sealed class ExpenseDetailsEvent extends Equatable {
  const ExpenseDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchInitialExpenseEvent extends ExpenseDetailsEvent {
  final String groupId;
  const FetchInitialExpenseEvent({required this.groupId});
}

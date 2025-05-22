part of 'expense_details_bloc.dart';

enum ExpenseDetailsStatus { initial, loading, loaded, error }

class ExpenseDetailsState extends Equatable {
  final ExpenseDetailsStatus status;
  final List<ExpenseModel> model;

  const ExpenseDetailsState({
    this.status = ExpenseDetailsStatus.initial,
    this.model = const [],
  });

  ExpenseDetailsState copyWith({
    ExpenseDetailsStatus? status,
    List<ExpenseModel>? model,
  }) {
    return ExpenseDetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, model];
}

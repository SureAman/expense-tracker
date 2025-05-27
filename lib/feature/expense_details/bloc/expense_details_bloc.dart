import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:expense_tracker/core/dependencies/dependencies.dart';
import 'package:expense_tracker/core/models/expense_model.dart';
import 'package:expense_tracker/feature/expense_details/repository/expense_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expense_details_event.dart';
part 'expense_details_state.dart';

class ExpenseDetailsBloc
    extends Bloc<ExpenseDetailsEvent, ExpenseDetailsState> {
  final ExpenseRepositoryImpl expenseRepositoryImpl =
      getIt<ExpenseRepositoryImpl>();
  ExpenseDetailsBloc() : super(const ExpenseDetailsState()) {
    //For Fetching the alreay existing expenses that are added to the group
    on<FetchInitialExpenseEvent>(_fetchInitialExpenseEvent);
  }

  FutureOr<void> _fetchInitialExpenseEvent(
    FetchInitialExpenseEvent event,
    Emitter<ExpenseDetailsState> emit,
  ) async {
    emit(state.copyWith(status: ExpenseDetailsStatus.loading));

    final expenseModel = await expenseRepositoryImpl.fetchExpenses();

    List<ExpenseModel> refinedExpenseModel =
        expenseModel
            .where((eachExpense) => eachExpense.groupId == event.groupId)
            .toList();

    emit(
      state.copyWith(
        status: ExpenseDetailsStatus.loaded,
        model: refinedExpenseModel,
      ),
    );
  }
}

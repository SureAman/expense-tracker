import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:expense_tracker/core/database/shared_preferences_manager.dart';
import 'package:expense_tracker/core/models/contacts_model.dart';
import 'package:expense_tracker/core/models/expense_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expense_details_event.dart';
part 'expense_details_state.dart';

class ExpenseDetailsBloc
    extends Bloc<ExpenseDetailsEvent, ExpenseDetailsState> {
  ExpenseDetailsBloc() : super(const ExpenseDetailsState()) {
    on<FetchInitialExpenseEvent>(_fetchInitialExpenseEvent);
  }

  FutureOr<void> _fetchInitialExpenseEvent(
    FetchInitialExpenseEvent event,
    Emitter<ExpenseDetailsState> emit,
  ) async {
    emit(state.copyWith(status: ExpenseDetailsStatus.loading));

    final expenseModel = await SharedPreferencesManager.getExpenses();

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

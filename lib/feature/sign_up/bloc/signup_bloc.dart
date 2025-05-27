import 'package:expense_tracker/core/dependencies/dependencies.dart';
import 'package:expense_tracker/feature/sign_up/bloc/signup_event.dart';
import 'package:expense_tracker/feature/sign_up/bloc/signup_state.dart';
import 'package:expense_tracker/feature/sign_up/repository/signup_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupRepositoryImpl signupRepositoryImpl =
      getIt<SignupRepositoryImpl>();
  SignupBloc() : super(SignupState.initial()) {
    on<FormSubmitted>((event, emit) async {
      emit(
        state.copyWith(
          isLoading: true,
          isErrorOccured: false,
          isSubmittedSuccessfully: false,
        ),
      );
      await signupRepositoryImpl.addNameAndNumber(event.name, event.number);
      // Future.delayed(const Duration(seconds: 2));
      emit(
        state.copyWith(
          isLoading: false,
          isErrorOccured: false,
          isSubmittedSuccessfully: true,
        ),
      );
    });
  }
}

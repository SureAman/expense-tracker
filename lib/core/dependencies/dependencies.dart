import 'package:expense_tracker/feature/add_expense/repository/add_expense_repository.dart';
import 'package:expense_tracker/feature/create_group/repository/create_group_repository.dart';
import 'package:expense_tracker/feature/expense_details/repository/expense_repository.dart';
import 'package:expense_tracker/feature/home/repository/home_repository.dart';
import 'package:expense_tracker/feature/sign_up/repository/signup_repository.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<AddExpenseRepositoryImpl>(
    () => AddExpenseRepositoryImpl(),
  );
  getIt.registerLazySingleton<CreateGroupRepoImpl>(() => CreateGroupRepoImpl());
  getIt.registerLazySingleton<HomeRepositoryImpl>(() => HomeRepositoryImpl());
  getIt.registerLazySingleton<ExpenseRepositoryImpl>(
    () => ExpenseRepositoryImpl(),
  );
  getIt.registerLazySingleton<SignupRepositoryImpl>(
    () => SignupRepositoryImpl(),
  );
}

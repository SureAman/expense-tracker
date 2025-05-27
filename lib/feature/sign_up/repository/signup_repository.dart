import 'package:expense_tracker/core/database/shared_preferences_manager.dart';

abstract class SignupRepository {
  Future<void> addNameAndNumber(String name, String number);
}

class SignupRepositoryImpl extends SignupRepository {
  @override
  Future<void> addNameAndNumber(String name, String number) async {
    await Future.delayed(const Duration(seconds: 2), () {
      SharedPreferencesManager.saveNameAndNumber(name, number);
    });
  }
}

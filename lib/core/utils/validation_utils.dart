import 'package:expense_tracker/core/constants/names.dart';

mixin ValidationUtils {
  String? validateName(String? value) {
    if (value != null) {
      if (value.trim().isEmpty) {
        return NameConstants.pleaseEnterValidName;
      }
      return null;
    } else {
      return NameConstants.nameCannotBeEmpty;
    }
  }

  String? validateNumber(String? value) {
    if (value != null) {
      if (value.length != 10) {
        return NameConstants.enterValidNumber;
      }
    } else {
      return NameConstants.numberCannotBeEmpty;
    }
    return null;
  }
}

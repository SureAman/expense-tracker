class SignupState {
  final bool isValidName;
  final bool isValidNumber;
  final bool isValidForm;
  final bool isSubmittedSuccessfully;
  final bool isLoading;
  final bool isErrorOccured;

  SignupState({
    required this.isValidName,
    required this.isValidNumber,
    required this.isValidForm,

    this.isSubmittedSuccessfully = false,
    this.isLoading = false,
    this.isErrorOccured = false,
  });

  factory SignupState.initial() {
    return SignupState(
      isValidName: true,
      isValidNumber: true,
      isValidForm: true,
    );
  }

  SignupState copyWith({
    bool? isValidName,
    bool? isValidNumber,
    bool? isValidForm,
    bool? isSubmittedSuccessfully,
    bool? isLoading,
    bool? isErrorOccured,
  }) {
    return SignupState(
      isValidName: isValidName ?? this.isValidName,
      isValidNumber: isValidNumber ?? this.isValidNumber,
      isValidForm: isValidForm ?? this.isValidForm,
      isSubmittedSuccessfully:
          isSubmittedSuccessfully ?? this.isSubmittedSuccessfully,
      isLoading: isLoading ?? this.isLoading,
      isErrorOccured: isErrorOccured ?? this.isErrorOccured,
    );
  }
}

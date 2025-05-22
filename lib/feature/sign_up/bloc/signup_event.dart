abstract class SignupEvent {}

class FormSubmitted extends SignupEvent {
  final String name;
  final String number;

  FormSubmitted({required this.name, required this.number});
}

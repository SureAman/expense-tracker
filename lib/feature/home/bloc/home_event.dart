import 'package:expense_tracker/core/models/contacts_model.dart';

abstract class HomeEvent {}

class FetchInitialData extends HomeEvent {}

// class CreateNewGroupEvent extends HomeEvent {
//   final String groupName;
//   List<ContactsModel> contacts;

//   CreateNewGroupEvent({required this.groupName, required this.contacts});
// }

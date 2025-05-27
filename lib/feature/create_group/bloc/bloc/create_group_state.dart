part of 'create_group_bloc.dart';

// @immutable
// sealed class CreateGroupState{}

// class CreateGroupInitial extends CreateGroupState{}

// class LoadingState extends CreateGroupState{}
// class ErrorState extends CreateGroupState{
//   final String? error;
//   ErrorState({required this.error});
// }
// class SuccessState extends CreateGroupState{}

// class SelectedIndicesState extends CreateGroupState{
//   final Set<int> selectedIndices;
//   SelectedIndicesState({required this.selectedIndices});
// }

// class ContactsState extends CreateGroupState{
//   final bool isPermissionDenied;
//   final List<Contact> contacts;
//   ContactsState({required this.contacts, required this.isPermissionDenied});
// }

enum CreateGroupStatus { initial, loading, success, error }

class CreateGroupState extends Equatable {
  final CreateGroupStatus status;

  final Set<int> selectedIndices;
  final List<Contact> contacts;
  final bool isPermissionDenied;

  const CreateGroupState({
    this.status = CreateGroupStatus.initial,
    this.selectedIndices = const <int>{},
    this.contacts = const [],
    this.isPermissionDenied = false,
  });

  CreateGroupState copyWith({
    CreateGroupStatus? status,
    Set<int>? selectedIndices,
    List<Contact>? contacts,
    bool? isPermissionDenied,
  }) {
    return CreateGroupState(
      status: status ?? this.status,
      selectedIndices: selectedIndices ?? this.selectedIndices,
      contacts: contacts ?? this.contacts,
      isPermissionDenied: isPermissionDenied ?? this.isPermissionDenied,
    );
  }

  @override
  List<Object?> get props => [
    status,
    selectedIndices,
    contacts,
    isPermissionDenied,
  ];
}

// final class CreateGroupInitial extends CreateGroupState {}

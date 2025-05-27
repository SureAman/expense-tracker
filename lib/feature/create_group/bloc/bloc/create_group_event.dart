part of 'create_group_bloc.dart';

abstract class CreateGroupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateNewGroupEvent extends CreateGroupEvent {
  final String groupName;

  CreateNewGroupEvent({required this.groupName});
}

class SelectedContactEvent extends CreateGroupEvent {
  final bool? value;
  final int index;

  SelectedContactEvent({required this.index, required this.value});
}

class FetchContactEvent extends CreateGroupEvent {}

class ResetSelectedIndices extends CreateGroupEvent {}

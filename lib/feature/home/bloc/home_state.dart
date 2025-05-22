import 'package:expense_tracker/core/models/group_model.dart';

class HomeState {
  final List<GroupModel> groupModel;
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;
  final String? name;

  HomeState({
    this.groupModel = const [],
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
    this.name,
  });

  HomeState copyWith({
    List<GroupModel>? groupModel,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    String? name,
  }) {
    return HomeState(
      groupModel: groupModel ?? this.groupModel,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      name: name ?? this.name,
    );
  }
}

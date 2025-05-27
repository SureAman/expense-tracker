import 'dart:async';

import 'package:expense_tracker/core/database/shared_preferences_manager.dart';
import 'package:expense_tracker/core/dependencies/dependencies.dart';
import 'package:expense_tracker/core/models/group_model.dart';
import 'package:expense_tracker/feature/home/bloc/home_event.dart';
import 'package:expense_tracker/feature/home/bloc/home_state.dart';
import 'package:expense_tracker/feature/home/repository/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepositoryImpl repositoryImpl = getIt<HomeRepositoryImpl>();
  HomeBloc() : super(HomeState()) {
    // For Fetching the group's that already exist
    on<FetchInitialData>(_fetchInitialData);
  }
  FutureOr<void> _fetchInitialData(
    FetchInitialData event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        groupModel: [],
        isLoading: true,
        isSuccess: false,
        errorMessage: "",
        name: "",
      ),
    );
    final groupList = await repositoryImpl.fetchGroups();
    final name = await repositoryImpl.getName();

    emit(
      state.copyWith(
        groupModel: groupList,
        isLoading: false,
        isSuccess: true,
        errorMessage: "",
        name: name ?? "",
      ),
    );
  }

  Future<List<GroupModel>> getGroupList() async {
    final List<GroupModel> groupList =
        await SharedPreferencesManager.getGroups();
    return groupList;
  }

  Future<String?> getName() async {
    final String? name = await SharedPreferencesManager.getName();
    return name;
  }
}

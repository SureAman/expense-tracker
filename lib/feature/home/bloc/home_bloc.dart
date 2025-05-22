import 'package:expense_tracker/core/database/shared_preferences_manager.dart';
import 'package:expense_tracker/core/models/group_model.dart';
import 'package:expense_tracker/feature/home/bloc/home_event.dart';
import 'package:expense_tracker/feature/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<FetchInitialData>((event, emit) async {
      emit(
        state.copyWith(
          groupModel: [],
          isLoading: true,
          isSuccess: false,
          errorMessage: "",
          name: "",
        ),
      );
      final groupList = await getGroupList();
      final name = await getName();
      print("name : $name");
      print("groupList : $groupList");

      emit(
        state.copyWith(
          groupModel: groupList,
          isLoading: false,
          isSuccess: true,
          errorMessage: "",
          name: name ?? "",
        ),
      );
    });

    // on<CreateNewGroupEvent>((event, emit) async {
    //   emit(state.copyWith(isLoading: true, isSuccess: false));
    //   final memberCount = event.contacts.length;
    //   SharedPreferencesManager.addGroup(
    //     GroupModel(
    //       id: "${event.groupName} $memberCount",
    //       name: event.groupName,
    //       members: memberCount + 1,
    //       //Doing +1 including myself
    //     ),
    //   );
    //   SharedPreferencesManager.addContacts(event.contacts);

    //   emit(
    //     state.copyWith(
    //       isLoading: false,
    //       isSuccess: true,
    //     ),
    //   );
    // });
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

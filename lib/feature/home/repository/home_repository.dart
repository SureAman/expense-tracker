import 'package:expense_tracker/core/database/shared_preferences_manager.dart';
import 'package:expense_tracker/core/models/group_model.dart';

abstract class HomeRepository {
  Future<List<GroupModel>> fetchGroups();
  Future<String?> getName();
}

class HomeRepositoryImpl extends HomeRepository {
  @override
  Future<List<GroupModel>> fetchGroups() async {
    List<GroupModel> model = [];
    await Future.delayed(Duration(seconds: 3), () async {
      model = await SharedPreferencesManager.getGroups();
    });
    return model;
  }

  @override
  Future<String?> getName() async {
    String? name;
    await Future.delayed(const Duration(seconds: 2), () async {
      name = await SharedPreferencesManager.getName();
    });
    return name;
  }
}

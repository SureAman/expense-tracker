import 'package:json_annotation/json_annotation.dart';

part 'group_model.g.dart';

@JsonSerializable()
class GroupModel {
  final String id;
  final String name;
  final int members;

  GroupModel({required this.id, required this.name, required this.members});

  factory GroupModel.fromMap(Map<String, dynamic> map) =>
      _$GroupModelFromJson(map);

  // factory GroupModel.fromMap(Map<String, dynamic> map) {
  //   return GroupModel(
  //     id: map['id'],
  //     name: map['name'],
  //     members: map['members'],
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return {'id': id, 'name': name, 'members': members};
  // }

  Map<String, dynamic> toMap() => _$GroupModelToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'user_item.g.dart';

@JsonSerializable()
class UserItem {
  @JsonKey(defaultValue: "", name: "id")
  String id;

  @JsonKey(defaultValue: false, name: "status")
  bool status;

  @JsonKey(name: "created_at")
  DateTime createdAt;

  UserItem({
    required this.id,
    required this.status,
    required this.createdAt,
  });

  factory UserItem.fromJson(Map<String, dynamic> json) => _$UserItemFromJson(json);
  Map<String, dynamic> toJson() => _$UserItemToJson(this);
}

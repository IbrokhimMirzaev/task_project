import 'package:json_annotation/json_annotation.dart';

part 'device_item.g.dart';

@JsonSerializable()
class DeviceItem {
  @JsonKey(defaultValue: "", name: "id")
  String id;

  @JsonKey(defaultValue: "", name: "uid")
  String uid;

  @JsonKey(defaultValue: "", name: "name")
  String name;

  @JsonKey(name: "created_at")
  DateTime createdAt;

  DeviceItem({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.uid,
  });

  factory DeviceItem.fromJson(Map<String, dynamic> json) => _$DeviceItemFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceItemToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'message_item.g.dart';

@JsonSerializable()
class MessageItem {
  @JsonKey(defaultValue: "", name: "messageId")
  String messageId;

  @JsonKey(defaultValue: "", name: "sender_name")
  String senderName;

  @JsonKey(defaultValue: "", name: "uid")
  String uid;

  @JsonKey(defaultValue: "", name: "message")
  String message;

  @JsonKey(name: "created_at")
  DateTime createdAt;

  MessageItem({
    required this.uid,
    required this.message,
    required this.createdAt,
    required this.messageId,
    required this.senderName,
  });

  factory MessageItem.fromJson(Map<String, dynamic> json) => _$MessageItemFromJson(json);
  Map<String, dynamic> toJson() => _$MessageItemToJson(this);
}

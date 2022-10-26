// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageItem _$MessageItemFromJson(Map<String, dynamic> json) => MessageItem(
      uid: json['uid'] as String? ?? '',
      message: json['message'] as String? ?? '',
      createdAt: DateTime.parse(json['created_at'] as String),
      messageId: json['messageId'] as String? ?? '',
      senderName: json['sender_name'] as String? ?? '',
    );

Map<String, dynamic> _$MessageItemToJson(MessageItem instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'sender_name': instance.senderName,
      'uid': instance.uid,
      'message': instance.message,
      'created_at': instance.createdAt.toIso8601String(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserItem _$UserItemFromJson(Map<String, dynamic> json) => UserItem(
      id: json['id'] as String? ?? '',
      status: json['status'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$UserItemToJson(UserItem instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
    };

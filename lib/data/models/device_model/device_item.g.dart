// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceItem _$DeviceItemFromJson(Map<String, dynamic> json) => DeviceItem(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$DeviceItemToJson(DeviceItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'created_at': instance.createdAt.toIso8601String(),
    };

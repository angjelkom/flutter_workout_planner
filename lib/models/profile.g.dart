// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map json) => Profile(
      json['gender'] as String,
      DateTime.parse(json['birth'] as String),
      (json['height'] as num).toDouble(),
      json['heightUnit'] as String,
      (json['weight'] as num).toDouble(),
      json['weightUnit'] as String,
      json['name'] as String,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'gender': instance.gender,
      'birth': instance.birth.toIso8601String(),
      'height': instance.height,
      'heightUnit': instance.heightUnit,
      'weight': instance.weight,
      'weightUnit': instance.weightUnit,
      'name': instance.name,
    };

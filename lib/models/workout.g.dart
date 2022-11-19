// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workout _$WorkoutFromJson(Map json) => Workout(
      json['id'] as String?,
      json['name'] as String,
      Exercise.fromJson(Map<String, dynamic>.from(json['exercise'] as Map)),
      (json['sets'] as List<dynamic>)
          .map((e) => WorkoutSet.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      json['rest'] == null ? null : Duration(microseconds: json['rest'] as int),
      _$JsonConverterFromJson<int, Color>(
          json['color'], const ColorConverter().fromJson),
      json['notes'] as String,
    );

Map<String, dynamic> _$WorkoutToJson(Workout instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'exercise': instance.exercise.toJson(),
      'sets': instance.sets.map((e) => e.toJson()).toList(),
      'rest': instance.rest?.inMicroseconds,
      'color': _$JsonConverterToJson<int, Color>(
          instance.color, const ColorConverter().toJson),
      'notes': instance.notes,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

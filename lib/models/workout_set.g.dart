// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutSet _$WorkoutSetFromJson(Map json) => WorkoutSet(
      json['id'] as String,
      json['sets'] as int,
      json['reps'] as int,
      json['weight'] as int,
    );

Map<String, dynamic> _$WorkoutSetToJson(WorkoutSet instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sets': instance.sets,
      'reps': instance.reps,
      'weight': instance.weight,
    };

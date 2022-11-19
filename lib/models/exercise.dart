import 'package:json_annotation/json_annotation.dart';

part 'exercise.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class Exercise {
  final String id;
  final String name;
  final String icon;

  const Exercise(this.id, this.name, this.icon);

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseToJson(this);
}

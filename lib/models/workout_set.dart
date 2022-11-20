import 'package:json_annotation/json_annotation.dart';

part 'workout_set.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class WorkoutSet {
  final String id;
  final int sets;
  final int reps;
  final int weight;

  WorkoutSet(this.id, this.sets, this.reps, this.weight);

  WorkoutSet.fromData(this.id, String sets, String reps, String weight)
      : sets = int.parse(sets),
        reps = int.parse(reps),
        weight = int.parse(weight);

  factory WorkoutSet.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSetFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutSetToJson(this);
}

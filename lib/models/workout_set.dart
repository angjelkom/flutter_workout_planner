import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

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

  // WorkoutSet.fromJson(Map<String, dynamic> json)
  //     : id = const Uuid().v1(),
  //       sets = json['sets'],
  //       reps = json['reps'],
  //       weight = json['weight'];

  // Map<String, dynamic> toJson() =>
  //     {'id': id, 'sets': sets, 'reps': reps, 'weight': weight};

  factory WorkoutSet.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSetFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutSetToJson(this);
}

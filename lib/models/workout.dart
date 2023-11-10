import 'package:json_annotation/json_annotation.dart';
part 'workout.g.dart';

@JsonSerializable()
class Workout {
  final String id;
  final String name;
  final int duration;

  Workout({this.id = '', required this.name, required this.duration});

  factory Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
import 'package:running_app_flutter/models/workout.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity {
  final String id;
  final String name;
  final int type;
  final int durationOfWorkouts;
  final List<Workout> workouts;
  final int isCompleted;

  Activity(
      {this.id = '',
      required this.name,
      required this.type,
      required this.durationOfWorkouts,
      required this.workouts,
      required this.isCompleted});

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}

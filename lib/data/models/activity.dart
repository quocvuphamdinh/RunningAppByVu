import 'package:json_annotation/json_annotation.dart';
import 'package:running_app_flutter/data/models/workout.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity {
  String id;
  String name;
  int type;
  int durationOfWorkouts;
  List<Workout> workouts;
  int isCompleted;

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

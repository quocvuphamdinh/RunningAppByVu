import 'package:json_annotation/json_annotation.dart';
part 'run.g.dart';

@JsonSerializable()
class Run {
  final String id;
  final int timestamp;
  final double averageSpeedInKilometersPerHour;
  final int distanceInKilometers;
  final int timeInMillis;
  final int caloriesBurned;
  final String? img;
  final int isRunWithExercise;

  Run(
      {this.id = '',
      required this.timestamp,
      required this.averageSpeedInKilometersPerHour,
      required this.distanceInKilometers,
      required this.timeInMillis,
      required this.caloriesBurned,
      this.img,
      required this.isRunWithExercise});

  factory Run.fromJson(Map<String, dynamic> json) => _$RunFromJson(json);

  Map<String, dynamic> toJson() => _$RunToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
part 'run.g.dart';

@JsonSerializable()
class Run {
  String id;
  int timestamp;
  double averageSpeedInKilometersPerHour;
  int distanceInKilometers;
  int timeInMillis;
  int caloriesBurned;
  String? img;
  int isRunWithExercise;

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

  @override
  String toString() {
    return "id: $id - timestamp: $timestamp - avg: $averageSpeedInKilometersPerHour - distance: $distanceInKilometers - timeInMillis: $timeInMillis - caloriesBurned: $caloriesBurned - img: $img - isRunWithExercise: $isRunWithExercise";
  }
}

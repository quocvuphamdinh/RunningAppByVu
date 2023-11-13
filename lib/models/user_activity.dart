import 'package:running_app_flutter/models/run.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_activity.g.dart';

@JsonSerializable()
class UserActivity {
  final String id;
  final Run? run;
  final String activityId;
  final String comment;
  final int mood;

  UserActivity(
      {this.id = '',
      this.run,
      required this.activityId,
      required this.comment,
      required this.mood});

  factory UserActivity.fromJson(Map<String, dynamic> json) =>
      _$UserActivityFromJson(json);

  Map<String, dynamic> toJson() => _$UserActivityToJson(this);
}
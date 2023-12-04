import 'package:json_annotation/json_annotation.dart';
import 'package:running_app_flutter/data/models/run.dart';

part 'user_activity.g.dart';

@JsonSerializable()
class UserActivity {
  String id;
  Run? run;
  String activityId;
  String comment;
  int mood;

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

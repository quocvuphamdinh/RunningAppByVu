import 'package:json_annotation/json_annotation.dart';
import 'package:running_app_flutter/data/models/run.dart';

part 'user_activity.g.dart';

@JsonSerializable()
class UserActivity {
  int? id;
  Run? run;
  int activityId;
  String comment;
  int mood;

  UserActivity(
      {this.id,
      this.run,
      required this.activityId,
      required this.comment,
      required this.mood});

  factory UserActivity.fromJson(Map<String, dynamic> json) =>
      _$UserActivityFromJson(json);

  factory UserActivity.fromJson2(Map<String, dynamic> json, Run? run) {
    return UserActivity(
      id: int.parse(json['id']),
      run: run,
      activityId: json['activityId'] as int,
      comment: json['comment'] as String,
      mood: json['mood'] as int,
    );
  }

  Map<String, dynamic> toJson() => _$UserActivityToJson(this);
}

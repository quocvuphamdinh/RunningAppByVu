import 'package:json_annotation/json_annotation.dart';
import 'package:running_app_flutter/data/models/activity.dart';
import 'package:running_app_flutter/data/models/run.dart';
part 'user_activity_detail.g.dart';

@JsonSerializable()
class UserActivityDetail {
  int? id;
  Run run;
  Activity activity;
  String? comment;
  int? mood;

  UserActivityDetail(
      {this.id,
      required this.run,
      required this.activity,
      this.comment,
      this.mood});

  factory UserActivityDetail.fromJson(Map<String, dynamic> json) =>
      _$UserActivityDetailFromJson(json);

  Map<String, dynamic> toJson() => _$UserActivityDetailToJson(this);
}

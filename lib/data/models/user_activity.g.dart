// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserActivity _$UserActivityFromJson(Map<String, dynamic> json) => UserActivity(
      id: json['id'] as int?,
      run: json['run'] == null
          ? null
          : Run.fromJson(json['run'] as Map<String, dynamic>),
      activityId: json['activityId'] as int,
      comment: json['comment'] as String,
      mood: json['mood'] as int,
    );

Map<String, dynamic> _$UserActivityToJson(UserActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'run': instance.run,
      'activityId': instance.activityId,
      'comment': instance.comment,
      'mood': instance.mood,
    };

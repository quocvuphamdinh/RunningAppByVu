// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_activity_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserActivityDetail _$UserActivityDetailFromJson(Map<String, dynamic> json) =>
    UserActivityDetail(
      id: json['id'] as int?,
      run: Run.fromJson(json['run'] as Map<String, dynamic>),
      activity: Activity.fromJson(json['activity'] as Map<String, dynamic>),
      comment: json['comment'] as String?,
      mood: json['mood'] as int?,
    );

Map<String, dynamic> _$UserActivityDetailToJson(UserActivityDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'run': instance.run,
      'activity': instance.activity,
      'comment': instance.comment,
      'mood': instance.mood,
    };

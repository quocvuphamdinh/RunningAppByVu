// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      id: json['id'] as int?,
      name: json['name'] as String,
      type: json['type'] as int,
      durationOfWorkouts: json['durationOfWorkouts'] as int,
      workouts: (json['workouts'] as List<dynamic>)
          .map((e) => Workout.fromJson(e as Map<String, dynamic>))
          .toList(),
      isCompleted:
          json['isCompleted'] == null ? 0 : json['isCompleted']! as int,
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'durationOfWorkouts': instance.durationOfWorkouts,
      'workouts': instance.workouts,
      'isCompleted': instance.isCompleted,
    };

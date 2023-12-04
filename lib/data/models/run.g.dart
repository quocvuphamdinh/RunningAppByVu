// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'run.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Run _$RunFromJson(Map<String, dynamic> json) => Run(
      id: json['id'] as String? ?? '',
      timestamp: json['timestamp'] as int,
      averageSpeedInKilometersPerHour:
          (json['averageSpeedInKilometersPerHour'] as num).toDouble(),
      distanceInKilometers: json['distanceInKilometers'] as int,
      timeInMillis: json['timeInMillis'] as int,
      caloriesBurned: json['caloriesBurned'] as int,
      img: json['img'] as String?,
      isRunWithExercise: json['isRunWithExercise'] as int,
    );

Map<String, dynamic> _$RunToJson(Run instance) => <String, dynamic>{
      'id': instance.id,
      'timestamp': instance.timestamp,
      'averageSpeedInKilometersPerHour':
          instance.averageSpeedInKilometersPerHour,
      'distanceInKilometers': instance.distanceInKilometers,
      'timeInMillis': instance.timeInMillis,
      'caloriesBurned': instance.caloriesBurned,
      'img': instance.img,
      'isRunWithExercise': instance.isRunWithExercise,
    };

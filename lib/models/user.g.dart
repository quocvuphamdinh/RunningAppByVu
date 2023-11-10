// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String? ?? '',
      userName: json['userName'] as String,
      passWord: json['passWord'] as String,
      fullName: json['fullName'] as String,
      avartar: json['avartar'] as String?,
      gender: json['gender'] as String,
      weight: json['weight'] as int,
      height: json['height'] as int,
      distanceGoal: json['distanceGoal'] as int?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'passWord': instance.passWord,
      'fullName': instance.fullName,
      'avartar': instance.avartar,
      'gender': instance.gender,
      'weight': instance.weight,
      'height': instance.height,
      'distanceGoal': instance.distanceGoal,
    };

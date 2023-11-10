import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String userName;
  final String passWord;
  final String fullName;
  final String? avartar;
  final String gender;
  final int weight;
  final int height;
  final int? distanceGoal;

  User(
      {this.id = '',
      required this.userName,
      required this.passWord,
      required this.fullName,
      this.avartar,
      required this.gender,
      required this.weight,
      required this.height,
      this.distanceGoal});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

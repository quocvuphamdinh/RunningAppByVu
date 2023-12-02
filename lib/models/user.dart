import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  String id;
  String userName;
  String passWord;
  String fullName;
  String? avartar;
  String gender;
  int weight;
  int height;
  int distanceGoal;

  User(
      {this.id = '',
      required this.userName,
      required this.passWord,
      required this.fullName,
      this.avartar,
      required this.gender,
      required this.weight,
      required this.height,
      this.distanceGoal = 0});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

import 'package:running_app_flutter/data/models/user.dart';

abstract class UserRepository {
  Future<void> register({required User user});
  Future<dynamic> checkEmailExists({required String email});
}

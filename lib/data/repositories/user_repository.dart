import 'package:running_app_flutter/data/models/user.dart';
import 'package:running_app_flutter/models/data_state.dart';

abstract class UserRepository {
  Future<DataState<void>> register({required User user});
  Future<DataState<User>> login(
      {required String username, required String password});
  Future<DataState<Map<String, String>>> sendOTPToEmail(
      {required String email});
  Future<DataState<User>> checkEmailAccount({required String username});
  Future<DataState<bool>> checkOTP({required String otpCode});
  Future<DataState<Map<String, String>>> resetPassword({required User user});
}

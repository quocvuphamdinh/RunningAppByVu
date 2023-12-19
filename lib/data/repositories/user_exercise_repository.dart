import 'package:running_app_flutter/data/models/user_activity.dart';
import 'package:running_app_flutter/data/models/user_activity_detail.dart';
import 'package:running_app_flutter/models/data_state.dart';

abstract class UserExerciseRepository {
  Future<void> insertUserExercise({required UserActivity userActivity});
  Future<List<UserActivity>> getAll();
  Future<void> deleteAll();
  Future<DataState<List<UserActivityDetail>>> getListUserExercise(
      {required int userId, int page = 0});
  Future<DataState<Map<String, String>>> calculateDataRecentActivity(
      {required int userId});
  Future<DataState<UserActivity>> insertUserExerciseToNetwork(
      {required UserActivity userActivity, required int userId});
  Future<DataState<UserActivity>> updateUserExercise(
      {required UserActivity userActivity, required int userId});
  Future<DataState<Map<String, bool>>> deleteUserExercise(
      {required int userActivityId});
}

import 'package:running_app_flutter/data/models/user_activity_detail.dart';
import 'package:running_app_flutter/models/data_state.dart';

abstract class UserExerciseRepository {
  Future<DataState<List<UserActivityDetail>>> getListUserExercise(
      {required int userId, int page = 0});
}

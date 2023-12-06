import 'package:running_app_flutter/data/models/activity.dart';
import 'package:running_app_flutter/models/data_state.dart';

abstract class ExerciseRepository {
  Future<DataState<List<Activity>>> getListExerciseByType(
      {required int type, required int userId, int size = 0});
}

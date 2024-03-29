import 'package:running_app_flutter/constant/data_run_types.dart';
import 'package:running_app_flutter/data/models/run.dart';
import 'package:running_app_flutter/models/data_state.dart';
import 'package:running_app_flutter/presentation/home/analysis/models/analysis_bar_model.dart';

abstract class RunRepository {
  Future<int> insertRun({required Run run});
  Future<void> insertRuns({required List<Run> runs});
  Future<DataState<void>> insertRunToNetwork(
      {required Run run, required int userId, int userActivitesId = -1});
  Future<List<Run>> getAllByType({required int type});
  Future<List<Run>> getAllRun();
  Future<Run> getRunById({required String id});
  Future<void> deleteRun({required String id});
  Future<void> deleteAllRun();
  Future<int> getTotalCaloriesBurnedToDay();
  Future<int> getTotalTimeInMillisToday();
  Future<double> getTotalAvgSpeedInKMHToday();
  Future<int> getCountRunToday();
  Future<int> getTotalDitanceWeekly();
  Future<int> getMaxDistance();
  Future<int> getMaxTimeInMillies();
  Future<int> getMaxCaloriesBurned();
  Future<double> getMaxAvgSpeedInKMH();
  Future<List<AnalysisBarModel>> getTotalRunDataInEachDay(
      int date, DataRunTypes type);
  Future<List<AnalysisBarModel>> getTotalRunDataInEachMonth(
      int date, DataRunTypes type);
  Future<int> getTotalTimeInMillies();
  Future<double> getTotalAvgSpeedInKMH();
  Future<int> getTotalCaloriesBurned();
  Future<int> getTotalDistance();
  Future<List<Run>> getAllRunsSortedByType(
      {required int isRunWithExercise, required SortType sortType});
  Future<DataState<List<Run>>> getRunsFromNetwork({required int userId});
  Future<DataState<Map<String, String>>> deleteRunRemote({required Run run});
}

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/constant/constant.dart';
import 'package:running_app_flutter/constant/data_run_types.dart';
import 'package:running_app_flutter/constant/error_code.dart';
import 'package:running_app_flutter/data/models/run.dart';
import 'package:running_app_flutter/data/providers/database/entities/run_entity.dart';
import 'package:running_app_flutter/data/providers/network/api_service.dart';
import 'package:running_app_flutter/data/repositories/run_repository.dart';
import 'package:running_app_flutter/models/app_error.dart';
import 'package:running_app_flutter/models/data_state.dart';
import 'package:running_app_flutter/presentation/home/analysis/models/analysis_bar_model.dart';

class RunRepositoryImpl extends RunRepository {
  final apiService = Get.find<ApiService>();

  @override
  Future<int> insertRun({required Run run}) {
    return RunEntity.create(run: run);
  }

  @override
  Future<void> insertRuns({required List<Run> runs}) async {
    for (var run in runs) {
      RunEntity.create(run: run);
    }
  }

  @override
  Future<List<Run>> getAllByType({required int type}) {
    return RunEntity.getAllByType(type: type);
  }

  @override
  Future<Run> getRunById({required String id}) {
    return RunEntity.getById(id: id);
  }

  @override
  Future<DataState<List<Run>>> getRunsFromNetwork({required int userId}) async {
    try {
      final httpResponse = await apiService.getRuns(userId);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(AppError(
          errorCode: httpResponse.response.statusCode ??
              ErrorCode.INTERNAL_SERVER_ERROR,
          errorTitle: Constant.TITLE_ALERT,
          errorMsg:
              httpResponse.response.statusMessage ?? "Error Sync data run !!"));
    } on DioException catch (e) {
      return DataFailed(AppError(
          errorCode: ErrorCode.INTERNAL_SERVER_ERROR,
          errorTitle: Constant.TITLE_ALERT,
          errorMsg: e.message.toString()));
    }
  }

  @override
  Future<List<Run>> getAllRun() {
    return RunEntity.getAll();
  }

  @override
  Future<DataState<void>> insertRunToNetwork(
      {required Run run, required int userId, int userActivitesId = -1}) async {
    try {
      final httpResponse =
          await apiService.insertRun(run, userId, userActivitesId);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(AppError(
          errorCode: httpResponse.response.statusCode ??
              ErrorCode.INTERNAL_SERVER_ERROR,
          errorTitle: Constant.TITLE_ALERT,
          errorMsg: httpResponse.response.statusMessage ??
              "Error Sync data to server !!"));
    } on DioException catch (e) {
      return DataFailed(AppError(
          errorCode: ErrorCode.INTERNAL_SERVER_ERROR,
          errorTitle: Constant.TITLE_ALERT,
          errorMsg: e.message.toString()));
    }
  }

  @override
  Future<DataState<Map<String, String>>> deleteRunRemote(
      {required Run run}) async {
    try {
      final httpResponse = await apiService.deleteRunRemote(run);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if (httpResponse.data["message"]!.contains("successfully")) {
          return DataSuccess(httpResponse.data);
        }
        return DataFailed(AppError(
            errorCode:
                httpResponse.response.statusCode ?? ErrorCode.NOT_ACCEPTABLE,
            errorTitle: Constant.TITLE_ALERT,
            errorMsg: httpResponse.response.data["message"] ??
                "Error delete run !!"));
      }
      return DataFailed(AppError(
          errorCode: httpResponse.response.statusCode ??
              ErrorCode.INTERNAL_SERVER_ERROR,
          errorTitle: Constant.TITLE_ALERT,
          errorMsg:
              httpResponse.response.statusMessage ?? "Error delete run !!"));
    } on DioException catch (e) {
      return DataFailed(AppError(
          errorCode: ErrorCode.INTERNAL_SERVER_ERROR,
          errorTitle: Constant.TITLE_ALERT,
          errorMsg: e.message.toString()));
    }
  }

  @override
  Future<void> deleteAllRun() {
    return RunEntity.deleteAll();
  }

  @override
  Future<int> getTotalCaloriesBurnedToDay() {
    return RunEntity.getTotalCaloriesBurnedToDay();
  }

  @override
  Future<int> getCountRunToday() {
    return RunEntity.getCountRunToday();
  }

  @override
  Future<double> getTotalAvgSpeedInKMHToday() {
    return RunEntity.getTotalAvgSpeedInKMHToday();
  }

  @override
  Future<int> getTotalTimeInMillisToday() {
    return RunEntity.getTotalTimeInMillisToday();
  }

  @override
  Future<int> getTotalDitanceWeekly() {
    return RunEntity.getTotalDitanceWeekly();
  }

  @override
  Future<double> getMaxAvgSpeedInKMH() {
    return RunEntity.getMaxAvgSpeedInKMH();
  }

  @override
  Future<int> getMaxCaloriesBurned() {
    return RunEntity.getMaxCaloriesBurned();
  }

  @override
  Future<int> getMaxDistance() {
    return RunEntity.getMaxDistance();
  }

  @override
  Future<int> getMaxTimeInMillies() {
    return RunEntity.getMaxTimeInMillies();
  }

  @override
  Future<List<AnalysisBarModel>> getTotalRunDataInEachDay(
      int date, DataRunTypes type) async {
    final resultFromDB = await RunEntity.getTotalRunDataInEachDay(date, type);
    return resultFromDB
        .asMap()
        .map((i, e) => MapEntry(
            i,
            AnalysisBarModel(
                id: i,
                name: AnalysisBarModel.getDayTitle(i + 1),
                y: type == DataRunTypes.DURATION
                    ? Duration(milliseconds: e).inMinutes.toDouble()
                    : e.toDouble())))
        .values
        .toList();
  }

  @override
  Future<List<AnalysisBarModel>> getTotalRunDataInEachMonth(
      int date, DataRunTypes type) async {
    final resultFromDB = await RunEntity.getTotalRunDataInEachMonth(date, type);
    return resultFromDB
        .asMap()
        .map((i, e) => MapEntry(
            i,
            AnalysisBarModel(
                id: i,
                name: (i + 1).toString(),
                y: type == DataRunTypes.DURATION
                    ? Duration(milliseconds: e).inMinutes.toDouble()
                    : e.toDouble())))
        .values
        .toList();
  }

  @override
  Future<double> getTotalAvgSpeedInKMH() {
    return RunEntity.getTotalAvgSpeedInKMH();
  }

  @override
  Future<int> getTotalCaloriesBurned() {
    return RunEntity.getTotalCaloriesBurned();
  }

  @override
  Future<int> getTotalDistance() {
    return RunEntity.getTotalDistance();
  }

  @override
  Future<int> getTotalTimeInMillies() {
    return RunEntity.getTotalTimeInMillies();
  }

  @override
  Future<List<Run>> getAllRunsSortedByType(
      {required int isRunWithExercise, required SortType sortType}) {
    return RunEntity.getAllRunsSortedByType(isRunWithExercise, sortType);
  }

  @override
  Future<void> deleteRun({required String id}) {
    return RunEntity.delete(id: id);
  }
}

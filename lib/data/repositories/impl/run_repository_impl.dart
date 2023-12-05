import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/constant/error_code.dart';
import 'package:running_app_flutter/data/models/run.dart';
import 'package:running_app_flutter/data/providers/database/entities/run_entity.dart';
import 'package:running_app_flutter/data/providers/network/api_service.dart';
import 'package:running_app_flutter/data/repositories/run_repository.dart';
import 'package:running_app_flutter/models/app_error.dart';
import 'package:running_app_flutter/models/data_state.dart';

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
          errorTitle: "Sync data run failed",
          errorMsg:
              httpResponse.response.statusMessage ?? "Error Sync data run !!"));
    } on DioException catch (e) {
      return DataFailed(AppError(
          errorCode: ErrorCode.INTERNAL_SERVER_ERROR,
          errorTitle: "Error",
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
          errorTitle: "Sync data to server failed",
          errorMsg: httpResponse.response.statusMessage ??
              "Error Sync data to server !!"));
    } on DioException catch (e) {
      return DataFailed(AppError(
          errorCode: ErrorCode.INTERNAL_SERVER_ERROR,
          errorTitle: "Error",
          errorMsg: e.message.toString()));
    }
  }

  @override
  Future<void> deleteAllRun() {
    return RunEntity.deleteAll();
  }
}

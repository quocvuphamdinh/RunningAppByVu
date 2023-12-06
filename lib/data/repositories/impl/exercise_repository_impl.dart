import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/constant/error_code.dart';
import 'package:running_app_flutter/data/models/activity.dart';
import 'package:running_app_flutter/data/providers/network/api_service.dart';
import 'package:running_app_flutter/data/repositories/exercise_repository.dart';
import 'package:running_app_flutter/models/app_error.dart';
import 'package:running_app_flutter/models/data_state.dart';

class ExerciseRepositoryImpl extends ExerciseRepository {
  final apiService = Get.find<ApiService>();
  @override
  Future<DataState<List<Activity>>> getListExerciseByType(
      {required int type, required int userId}) async {
    try {
      final httpResponse = await apiService.getListExerciseByType(type, userId);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(AppError(
          errorCode: httpResponse.response.statusCode ??
              ErrorCode.INTERNAL_SERVER_ERROR,
          errorTitle: "Get exercise failed",
          errorMsg:
              httpResponse.response.statusMessage ?? "Error Get exercise !!"));
    } on DioException catch (e) {
      return DataFailed(AppError(
          errorCode: ErrorCode.INTERNAL_SERVER_ERROR,
          errorTitle: "Error",
          errorMsg: e.message.toString()));
    }
  }
}

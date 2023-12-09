import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/constant/constant.dart';
import 'package:running_app_flutter/constant/error_code.dart';
import 'package:running_app_flutter/data/models/user_activity_detail.dart';
import 'package:running_app_flutter/data/providers/network/api_service.dart';
import 'package:running_app_flutter/data/repositories/user_exercise_repository.dart';
import 'package:running_app_flutter/models/app_error.dart';
import 'package:running_app_flutter/models/data_state.dart';

class UserExerciseRepositoryImpl extends UserExerciseRepository {
  final apiService = Get.find<ApiService>();
  @override
  Future<DataState<List<UserActivityDetail>>> getListUserExercise(
      {required int userId, int page = 0}) async {
    try {
      final httpResponse = await apiService.getListUserExercise(userId, page);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(AppError(
          errorCode: httpResponse.response.statusCode ??
              ErrorCode.INTERNAL_SERVER_ERROR,
          errorTitle: Constant.TITLE_ALERT,
          errorMsg: httpResponse.response.statusMessage ??
              "Error Get list user exercise !!"));
    } on DioException catch (e) {
      return DataFailed(AppError(
          errorCode: ErrorCode.INTERNAL_SERVER_ERROR,
          errorTitle: Constant.TITLE_ALERT,
          errorMsg: e.message.toString()));
    }
  }

  @override
  Future<DataState<Map<String, String>>> calculateDataRecentActivity(
      {required int userId}) async {
    try {
      final httpResponse = await apiService.calculateDataRecentActivity(userId);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(AppError(
          errorCode: httpResponse.response.statusCode ??
              ErrorCode.INTERNAL_SERVER_ERROR,
          errorTitle: Constant.TITLE_ALERT,
          errorMsg: httpResponse.response.statusMessage ??
              "Error calculate data run !!"));
    } on DioException catch (e) {
      return DataFailed(AppError(
          errorCode: ErrorCode.INTERNAL_SERVER_ERROR,
          errorTitle: Constant.TITLE_ALERT,
          errorMsg: e.message.toString()));
    }
  }
}

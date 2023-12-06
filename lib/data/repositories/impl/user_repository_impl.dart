import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/constant/error_code.dart';
import 'package:running_app_flutter/models/app_error.dart';
import 'package:running_app_flutter/data/models/user.dart';
import 'package:running_app_flutter/data/providers/network/api_service.dart';
import 'package:running_app_flutter/data/repositories/user_repository.dart';
import 'package:running_app_flutter/models/data_state.dart';

class UserRepositoryImpl extends UserRepository {
  final apiService = Get.find<ApiService>();
  @override
  Future<DataState<void>> register({required User user}) async {
    try {
      final httpResponse = await apiService.register(user);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(AppError(
          errorCode: httpResponse.response.statusCode ??
              ErrorCode.INTERNAL_SERVER_ERROR,
          errorTitle: "Sign up failed",
          errorMsg: httpResponse.response.statusMessage ?? "Error Sign up !!"));
    } on DioException catch (e) {
      return DataFailed(AppError(
          errorCode: ErrorCode.INTERNAL_SERVER_ERROR,
          errorTitle: "Error",
          errorMsg: e.message.toString()));
    }
  }

  @override
  Future<DataState<Map<String, String>>> sendOTPToEmail(
      {required String email}) async {
    try {
      final httpResponse = await apiService.checkEmailExists(email);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(AppError(
          errorCode: httpResponse.response.statusCode ??
              ErrorCode.INTERNAL_SERVER_ERROR,
          errorTitle: "Sign up failed",
          errorMsg: httpResponse.response.statusMessage ?? "Error Sign up !!"));
    } on DioException catch (e) {
      return DataFailed(AppError(
          errorCode: ErrorCode.INTERNAL_SERVER_ERROR,
          errorTitle: "Error",
          errorMsg: e.message.toString()));
    }
  }

  @override
  Future<DataState<User>> checkEmailAccount({required String username}) async {
    try {
      final httpResponse = await apiService.checkEmailAccount(username);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(AppError(
          errorCode: httpResponse.response.statusCode ??
              ErrorCode.INTERNAL_SERVER_ERROR,
          errorTitle: "Sign up failed",
          errorMsg: httpResponse.response.statusMessage ?? "Error Sign up !!"));
    } on DioException catch (e) {
      return DataFailed(AppError(
          errorCode: ErrorCode.INTERNAL_SERVER_ERROR,
          errorTitle: "Error",
          errorMsg: e.message.toString()));
    }
  }

  @override
  Future<DataState<bool>> checkOTP({required String otpCode}) async {
    try {
      final httpResponse = await apiService.checkOTPCode(otpCode);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        var message = httpResponse.data["message"];
        if (message == "OK") {
          return const DataSuccess(true);
        }
        return const DataSuccess(false);
      }
      return DataFailed(AppError(
          errorCode: httpResponse.response.statusCode ??
              ErrorCode.INTERNAL_SERVER_ERROR,
          errorTitle: "Check OTP failed",
          errorMsg:
              httpResponse.response.statusMessage ?? "Error Check OTP !!"));
    } on DioException catch (e) {
      return DataFailed(AppError(
          errorCode: ErrorCode.INTERNAL_SERVER_ERROR,
          errorTitle: "Error",
          errorMsg: e.message.toString()));
    }
  }

  @override
  Future<DataState<User>> login(
      {required String username, required String password}) async {
    try {
      final httpResponse = await apiService.login(username, password);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(AppError(
          errorCode: httpResponse.response.statusCode ??
              ErrorCode.INTERNAL_SERVER_ERROR,
          errorTitle: "Login failed",
          errorMsg: httpResponse.response.statusMessage ?? "Error Login !!"));
    } on DioException catch (e) {
      return DataFailed(AppError(
          errorCode: ErrorCode.INTERNAL_SERVER_ERROR,
          errorTitle: "Error",
          errorMsg: e.message.toString()));
    }
  }

  @override
  Future<DataState<Map<String, String>>> resetPassword(
      {required User user}) async {
    try {
      final httpResponse = await apiService.resetPassword(user);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(AppError(
          errorCode: httpResponse.response.statusCode ??
              ErrorCode.INTERNAL_SERVER_ERROR,
          errorTitle: "Reset password failed",
          errorMsg: httpResponse.response.statusMessage ??
              "Error Reset password !!"));
    } on DioException catch (e) {
      return DataFailed(AppError(
          errorCode: ErrorCode.INTERNAL_SERVER_ERROR,
          errorTitle: "Error",
          errorMsg: e.message.toString()));
    }
  }

  @override
  Future<DataState<void>> updateUser({required User user}) async {
    try {
      final httpResponse = await apiService.updateUser(user, user.id!);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(AppError(
          errorCode: httpResponse.response.statusCode ??
              ErrorCode.INTERNAL_SERVER_ERROR,
          errorTitle: "Update user failed",
          errorMsg:
              httpResponse.response.statusMessage ?? "Error Update user !!"));
    } on DioException catch (e) {
      return DataFailed(AppError(
          errorCode: ErrorCode.INTERNAL_SERVER_ERROR,
          errorTitle: "Error",
          errorMsg: e.message.toString()));
    }
  }
}

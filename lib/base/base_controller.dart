import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/models/app_error.dart';
import 'package:running_app_flutter/extensions/app_error_extension.dart';
import 'package:running_app_flutter/widgets/dialog/app_dialog.dart';

import '../constant/error_code.dart';

class BaseController extends GetxController {
  Future<bool> onBackPress() {
    return Future(() => true);
  }

  void showError(dynamic error,
      {VoidCallback? onPressed,
      bool dismissOnTap = true,
      StackTrace? stackTrace}) {
    if (error is AppError) {
      switch (error.errorCode) {
        case ErrorCode.BAD_GATEWAY:
          error = AppError().badGateway();
          break;
        case ErrorCode.BAD_REQUEST:
          error = AppError().badRequest();
          break;
        case ErrorCode.FORBIDDEN:
          error = AppError().forbidden();
          break;

        case ErrorCode.INTERNAL_SERVER_ERROR:
          error = AppError().internalServerError();
          break;

        case ErrorCode.METHOD_NOT_ALLOWED:
          error = AppError().methodNotAllowed();
          break;

        case ErrorCode.NOT_ACCEPTABLE:
          error = AppError().notAcceptable();
          break;

        case ErrorCode.NOT_FOUND:
          error = AppError().notFound();
          break;

        case ErrorCode.NOT_IMPLEMENTED:
          error = AppError().notImplement();
          break;

        case ErrorCode.REQUEST_TIMEOUT:
          error = AppError().requestTimeout();
          break;

        case ErrorCode.SERVICE_UNAVAILABLE:
          error = AppError().serviceUnavailable();
          break;

        case ErrorCode.UNAUTHORIZED:
          error = AppError().unAuthorized();
          break;
      }
      showAppDialog(
          title: error.errorTitle,
          button: 'OK',
          // content: '[${error.errorCode}]: ${error.errorMsg}',
          content: '${error.errorMsg}',
          onPressed: onPressed,
          dismissOnTap: dismissOnTap);

      /// DioError
    } else if (error is DioException) {
      var response = error.response;
      if (response != null) {
        log("[${response.statusCode}]: ${response.statusMessage}");
        showAppDialog(
            title: 'ERROR',
            button: 'OK',
            content: '[${response.statusCode}]: ${response.statusMessage}',
            onPressed: onPressed,
            dismissOnTap: dismissOnTap);
      } else {
        showAppDialog(
            title: 'ERROR',
            button: 'OK',
            content: 'Please check your network connection.',
            onPressed: onPressed,
            dismissOnTap: dismissOnTap);
      }
    }

    /// các exception còn lại
    else {
      showAppDialog(
          title: 'ERROR',
          button: 'OK',
          content: 'Some thing went wrong',
          onPressed: onPressed,
          dismissOnTap: dismissOnTap);
    }
  }

  /// handle click cho error cụ thể
  void showErrors(Object onError,
      {VoidCallback? onLoginExpired,
      VoidCallback? otherErrors,
      StackTrace? stackTrace}) {
    showError(onError, stackTrace: stackTrace, onPressed: () async {
      if (otherErrors != null) otherErrors();
      return;
    }, dismissOnTap: false);
  }

  void showAppDialog(
      {required String title,
      required String button,
      String? content,
      bool dismissOnTap = true,
      Function()? onPressed}) {
    Get.dialog<void>(
        AppDialog.commonDialog(
          title: title,
          content: content,
          action: button,
          onPressed: () {
            if (onPressed != null) {
              onPressed.call();
            }
            Get.back();
          },
        ),
        barrierDismissible: dismissOnTap);
  }

  /// TOAST
  void showToast(String message, {int duration = 2000}) {
    EasyLoading.showToast(message,
        duration: Duration(milliseconds: duration),
        toastPosition: EasyLoadingToastPosition.bottom);
  }

  void showToastCopiedToClipboard() {
    // showToast("copied_to_clipboard".tr);
    showSnackBar('Copy'.tr, "copied_to_clipboard".tr);
  }

  /// LOADING
  void showLoading({String? messaging, bool dismissOntTap = false}) {
    EasyLoading.show(
        status: messaging ?? 'processing'.tr,
        dismissOnTap: dismissOntTap,
        maskType: EasyLoadingMaskType.black);
  }

  /// LOADING
  void showSuccess() {
    EasyLoading.showSuccess('successfully'.tr);
  }

  void dismissLoading() {
    EasyLoading.dismiss();
  }

  bool isShowLoading() {
    return EasyLoading.isShow;
  }

  void showSnackBar(String title, String content,
      {SnackPosition position = SnackPosition.BOTTOM,
      Color bgColor = Colors.black12,
      Color textColor = AppColor.whiteColor}) {
    Get.snackbar(title, content,
        snackPosition: position,
        backgroundColor: bgColor,
        colorText: textColor);
  }
}

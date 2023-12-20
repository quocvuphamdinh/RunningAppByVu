import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/presentation/forgot_password/forgot_password_controller.dart';
import 'package:running_app_flutter/widgets/core/run_bottom_app_bar.dart';
import 'package:running_app_flutter/widgets/core/run_button.dart';
import 'package:running_app_flutter/widgets/core/run_textfield.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordController> {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.appBackgroundColor,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(AppDimens.mediumSpacingHor),
            child: Column(
              children: [
                Text(
                  "Forgot Password".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: AppDimens.biggestTextSize,
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: "SecularOne"),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: AppDimens.smallSpacingVer),
                  child: Text(
                    "Please enter your email address below and we will send a new password to you",
                    style: TextStyle(fontSize: AppDimens.mediumTextSize),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: AppDimens.mediumSpacingVer,
                      bottom: AppDimens.smallSpacingVer),
                  child: RunTextField(
                      controller: controller.emailController,
                      hintText: "Enter your email here"),
                ),
                RunButton(
                    buttonText: "Reset password",
                    onClick: () {
                      controller.onResetPass();
                    }),
              ],
            ),
          ),
          RunBottomAppBar(onArrowClick: () {
            Get.back();
          })
        ],
      )),
    );
  }
}

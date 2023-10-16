import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/constant/strings.dart';
import 'package:running_app_flutter/presentation/login/login_controller.dart';
import 'package:running_app_flutter/widgets/core/run_button.dart';
import 'package:running_app_flutter/widgets/core/run_textfield.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimens.mediumSpacingHor),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.only(top: AppDimens.mediumSpacingVer),
            child: Image.asset(
              "assets/images/runner.png",
              height: 200.h,
              width: 200.w,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppDimens.smallSpacingVer),
            child: Text(RunningAppStrings.titleApp,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: AppDimens.biggestTextSize,
                    fontWeight: FontWeight.bold,
                    fontFamily: "SecularOne")),
          ),
          RunTextField(
              controller: controller.emailController, hintText: "Email"),
          Obx(() => RunTextField(
                controller: controller.passwordController,
                hintText: "Password",
                isHidePassword: controller.isHidePassword.value,
                isObscureText: true,
                onClickSuffixIcon: controller.showPassword,
              )),
          Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: RunButton(buttonText: "Sign In", onClick: () {})),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Text("Forgot password?",
                style: TextStyle(fontSize: AppDimens.largeTextSize)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Text(
                  "Don't have an Account?",
                  style: TextStyle(fontSize: AppDimens.mediumTextSize),
                ),
              ),
              GestureDetector(
                child: Text(
                  "Go back",
                  style: TextStyle(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimens.mediumTextSize),
                ),
                onTap: () {
                  Get.back();
                },
              )
            ],
          )
        ]),
      ),
    ));
  }
}

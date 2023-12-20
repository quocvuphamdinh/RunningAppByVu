import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/config/res/app_image.dart';
import 'package:running_app_flutter/constant/strings.dart';
import 'package:running_app_flutter/presentation/login/login_controller.dart';
import 'package:running_app_flutter/routes/app_routes.dart';
import 'package:running_app_flutter/widgets/core/run_button.dart';
import 'package:running_app_flutter/widgets/core/run_textfield.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColor.appBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  left: AppDimens.mediumSpacingHor,
                  right: AppDimens.mediumSpacingHor,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.only(top: AppDimens.mediumSpacingVer),
                        child: Image(
                            image: AppImages.logoImage,
                            height: 200.h,
                            width: 200.w)),
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
                        controller: controller.emailController,
                        hintText: "Email"),
                    RunTextField(
                      controller: controller.passwordController,
                      hintText: "Password",
                      isObscureText: true,
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: RunButton(
                            buttonText: "Sign In",
                            onClick: () async {
                              controller.login();
                            })),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.ForgotPassword);
                        },
                        child: Text("Forgot password?",
                            style:
                                TextStyle(fontSize: AppDimens.largeTextSize)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: Text(
                              "Don't have an Account?",
                              style:
                                  TextStyle(fontSize: AppDimens.mediumTextSize),
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
                      ),
                    )
                  ]),
            ),
          ),
        ));
  }
}

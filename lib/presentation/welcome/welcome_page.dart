import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/config/res/app_image.dart';
import 'package:running_app_flutter/presentation/welcome/welcome_controller.dart';
import 'package:running_app_flutter/routes/app_routes.dart';
import 'package:running_app_flutter/widgets/core/run_button.dart';

import '../../constant/strings.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      body: SafeArea(
          child: Container(
        constraints: const BoxConstraints.expand(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Image(
              image: AppImages.logoImage,
              height: 200.h,
              width: 200.w,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Text(RunningAppStrings.titleApp,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: AppDimens.biggestTextSize,
                    fontWeight: FontWeight.bold,
                    fontFamily: "SecularOne")),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            child: Text(
              RunningAppStrings.subTitleApp,
              style: TextStyle(
                  fontSize: 20.sp,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                  fontFamily: "SecularOne"),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 40.h, left: 50.w, right: 50.w),
              child: RunButton(
                  buttonText: RunningAppStrings.textCreateAccount,
                  onClick: () {
                    Get.toNamed(AppRoutes.SignUp);
                  })),
          Container(
              margin: EdgeInsets.only(top: 10.h, left: 50.w, right: 50.w),
              child: RunButton(
                  buttonText: RunningAppStrings.textSignIn,
                  onClick: () {
                    Get.toNamed(AppRoutes.Login);
                  })),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Text(
                  RunningAppStrings.subTitleApp2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                      fontSize: 15.sp,
                      color: Colors.grey[600],
                      fontFamily: "SecularOne"),
                ),
              ),
            ),
          ),
        ]),
      )),
    );
  }
}

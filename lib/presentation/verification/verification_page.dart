import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/presentation/verification/verification_controller.dart';
import 'package:running_app_flutter/widgets/core/run_bottom_app_bar.dart';

class VerificationPage extends GetView<VerificationController> {
  const VerificationPage({super.key});

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Verification Code".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: AppDimens.biggestTextSize,
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: "SecularOne"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: AppDimens.smallSpacingVer,
                      horizontal: AppDimens.mediumSpacingHor),
                  child: Obx(() => Text(
                        "We have sent the OTP code to ${controller.email.value}, please check your gmail and enter the OTP code below to verify your account",
                        style: TextStyle(fontSize: AppDimens.mediumTextSize),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: AppDimens.mediumSpacingVer,
                      bottom: AppDimens.mediumSpacingVer),
                  child: OTPTextField(
                    controller: controller.otpController,
                    length: 4,
                    width: Get.width,
                    fieldWidth: (Get.width / 5),
                    outlineBorderRadius: 10.r,
                    style: TextStyle(fontSize: 17.sp),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.box,
                    otpFieldStyle: OtpFieldStyle(
                        borderColor: AppColor.primaryColor,
                        disabledBorderColor: AppColor.primaryColor,
                        enabledBorderColor: AppColor.primaryColor,
                        focusBorderColor: AppColor.yellowAppColor3),
                    onCompleted: (pin) {
                      controller.onCheckOTP(pin);
                    },
                    onChanged: (pin) {},
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Text(
                        "I don't receive a code?",
                        style: TextStyle(fontSize: AppDimens.mediumTextSize),
                      ),
                    ),
                    Obx(() => !controller.isSendAgain.value
                        ? GestureDetector(
                            child: Text(
                              "Please resend",
                              style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppDimens.mediumTextSize),
                            ),
                            onTap: () {
                              controller.onSendOTPAgain();
                            },
                          )
                        : const CupertinoActivityIndicator())
                  ],
                ),
              ],
            ),
          ),
          RunBottomAppBar(onArrowClick: () {
            controller.onBack();
          })
        ],
      )),
    );
  }
}

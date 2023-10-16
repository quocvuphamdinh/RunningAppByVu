import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/presentation/sign_up/sign_up_controller.dart';
import 'package:running_app_flutter/widgets/core/run_button.dart';
import 'package:running_app_flutter/widgets/core/run_textfield.dart';

class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.h, right: 20.w, left: 20.w),
              child: Text(
                "Let's start with some facts about you.",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 20.h, bottom: 10.h, right: 20.w, left: 20.w),
              child: Text(
                "LOGIN",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppDimens.smallSpacingHor),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RunTextField(
                        hintText: "Email",
                        controller: controller.textEmailController),
                    Obx(() => RunTextField(
                        hintText: "Password",
                        controller: controller.textPasswordController,
                        isObscureText: true,
                        isHidePassword: controller.isHidePassword.value,
                        onClickSuffixIcon: controller.showPassword)),
                    Obx(() => RunTextField(
                        hintText: "Repeat password",
                        controller: controller.textRepeatPasswordController,
                        isObscureText: true,
                        isHidePassword: controller.isHideRepeatPassword.value,
                        onClickSuffixIcon: controller.showRepeatPassword)),
                  ]),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 20.h, bottom: 10.h, right: 20.w, left: 20.w),
              child: Text(
                "PERSONAL DATA",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppDimens.smallSpacingHor),
              child: Column(
                children: [
                  RunTextField(
                      hintText: "Full name",
                      controller: controller.textFullNameController),
                  Obx(() => Container(
                      width: Get.size.width,
                      padding: EdgeInsets.only(left: 10.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.grey[300]),
                      height: 50.h,
                      child: DropdownButton<String>(
                          isExpanded: true,
                          items: const [
                            DropdownMenuItem(
                                child: Text("Male"), value: "Male"),
                            DropdownMenuItem(
                                child: Text("Female"), value: "Female"),
                            DropdownMenuItem(
                                child: Text("Other"), value: "Other")
                          ],
                          onChanged: controller.dropDownCallBack,
                          value: controller.selectedValue.value,
                          iconSize: AppDimens.iconLargeSize),
                      margin:
                          EdgeInsets.only(bottom: AppDimens.smallSpacingVer))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 10,
                        child: RunTextField(
                            controller: controller.textHeightController,
                            suffixIcon: const Icon(Icons.height),
                            hintText: "Height",
                            textInputType: TextInputType.number),
                      ),
                      const Spacer(flex: 1),
                      Expanded(
                        flex: 10,
                        child: RunTextField(
                            controller: controller.textWeightController,
                            suffixIcon: const Icon(Icons.line_weight),
                            hintText: "Weight",
                            textInputType: TextInputType.number),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: AppDimens.smallSpacingHor,
                  right: AppDimens.smallSpacingHor,
                  top: AppDimens.mediumSpacingVer),
              child: RunButton(buttonText: "Create Account", onClick: () {}),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: AppDimens.mediumSpacingHor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Text(
                      "Already have an Account?",
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
              ),
            )
          ],
        ),
      )),
    );
  }
}

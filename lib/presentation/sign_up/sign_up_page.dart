import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/presentation/sign_up/sign_up_controller.dart';
import 'package:running_app_flutter/widgets/core/run_textfield.dart';

class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10, right: 20, left: 20),
            child: Text(
              "Let's start with some facts about you.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 10, right: 20, left: 20),
            child: Text(
              "LOGIN",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
              child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppDimens.smallSpacingHor),
            child: Column(children: [
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
              const Padding(
                padding:
                    EdgeInsets.only(top: 20, bottom: 10, right: 20, left: 20),
                child: Text(
                  "PERSONAL DATA",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
              RunTextField(
                  hintText: "Full name",
                  controller: controller.textFullNameController),
              Obx(() => Container(
                  width: Get.size.width,
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300]),
                  height: 50.h,
                  child: DropdownButton<String>(
                      isExpanded: true,
                      items: const [
                        DropdownMenuItem(child: Text("Male"), value: "Male"),
                        DropdownMenuItem(
                            child: Text("Female"), value: "Female"),
                        DropdownMenuItem(child: Text("Other"), value: "Other")
                      ],
                      onChanged: controller.dropDownCallBack,
                      value: controller.selectedValue.value,
                      iconSize: 42.0),
                  margin: EdgeInsets.only(bottom: AppDimens.smallSpacingVer))),
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
            ]),
          )),
        ],
      )),
    );
  }
}

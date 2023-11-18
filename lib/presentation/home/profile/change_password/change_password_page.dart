import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/presentation/home/profile/change_password/change_password_controller.dart';
import 'package:running_app_flutter/widgets/appbar/app_bar_three_side.dart';
import 'package:running_app_flutter/widgets/core/run_textfield.dart';
import 'package:running_app_flutter/widgets/core/text_description.dart';
import 'package:running_app_flutter/widgets/core/text_title.dart';

class ChangePasswordPage extends GetView<ChangePasswordController> {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarThreeSide(
            widgetLeft: Text("Cancel",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
            onClickWidgetLeft: () {
              Get.back();
            },
            widgetCenter: const TextTitle(text: "Change Password"),
            widgetRight: Text("Save",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
          ),
          Expanded(
              child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppDimens.smallSpacingHor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextDescription(text: "Old password"),
                RunTextField(
                  controller: controller.oldPasswordController,
                  hintText: 'Enter old password here',
                  isObscureText: true,
                ),
                const TextDescription(text: "New password"),
                RunTextField(
                  controller: controller.newPasswordController,
                  hintText: 'Enter new password here',
                  isObscureText: true,
                ),
                const TextDescription(text: "Confirm password"),
                RunTextField(
                  controller: controller.confirmPasswordController,
                  hintText: 'Enter confirm password here',
                  isObscureText: true,
                )
              ],
            ),
          ))
        ],
      )),
    );
  }
}

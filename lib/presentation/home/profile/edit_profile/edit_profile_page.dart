import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/presentation/home/profile/edit_profile/edit_profile_controller.dart';
import 'package:running_app_flutter/widgets/appbar/app_bar_three_side.dart';
import 'package:running_app_flutter/widgets/core/run_text_drop_down.dart';
import 'package:running_app_flutter/widgets/core/run_textfield.dart';
import 'package:running_app_flutter/widgets/core/text_description.dart';
import 'package:running_app_flutter/widgets/core/text_title.dart';

class EditProfilePage extends GetView<EditProfileController> {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarThreeSide(
            widgetLeft: Text(
              "Cancel",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.grey),
            ),
            onClickWidgetLeft: () {
              Get.back();
            },
            widgetRight: Text(
              "Save",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.grey),
            ),
            onCLickWidgetRight: () {},
            widgetCenter: const TextTitle(text: "Edit Profile"),
          ),
          Expanded(
              child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppDimens.smallSpacingHor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextDescription(text: "Username"),
                    RunTextField(
                        controller: controller.usernameController,
                        isEnabled: false),
                    const TextDescription(text: "Fullname"),
                    RunTextField(controller: controller.fullnameController),
                    const TextDescription(text: "Gender"),
                    RunTextDropDown(listOptions: [
                      RunTextDropDownModel(name: "Male", value: "Male"),
                      RunTextDropDownModel(name: "Female", value: "Female"),
                      RunTextDropDownModel(name: "Other", value: "Other")
                    ], onSelectedValue: ((selectedValue) {})),
                    const TextDescription(text: "Height"),
                    RunTextField(
                        controller: controller.heightController,
                        textInputType: TextInputType.number,
                        suffixIcon: const Icon(Icons.height)),
                    const TextDescription(text: "Weight"),
                    RunTextField(
                        controller: controller.weightController,
                        textInputType: TextInputType.number,
                        suffixIcon: const Icon(Icons.line_weight)),
                  ],
                ),
              ),
            ),
          ))
        ],
      )),
    );
  }
}

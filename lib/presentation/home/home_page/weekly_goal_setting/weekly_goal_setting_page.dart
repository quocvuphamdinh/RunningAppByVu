import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/presentation/home/home_page/weekly_goal_setting/weekly_goal_setting_controller.dart';
import 'package:running_app_flutter/widgets/appbar/app_bar_three_side.dart';
import 'package:running_app_flutter/widgets/core/run_button.dart';
import 'package:running_app_flutter/widgets/core/text_title.dart';

class WeeklyGoalSettingPage extends GetView<WeeklyGoalSettingController> {
  const WeeklyGoalSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: Scaffold(
          backgroundColor: AppColor.appBackgroundColor,
          body: SafeArea(
              child: Column(
            children: [
              AppBarThreeSide(
                widgetLeft: Icon(Icons.close, size: AppDimens.iconSmallSize),
                onClickWidgetLeft: () {
                  controller.onBack();
                },
                widgetCenter: const TextTitle(text: "Weekly goal setting"),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 100.h,
                    left: AppDimens.mediumSpacingHor,
                    right: AppDimens.mediumSpacingHor,
                    bottom: AppDimens.mediumSpacingVer),
                child: Obx(() => NumberPicker(
                      textMapper: (text) {
                        return "$text km";
                      },
                      itemWidth: Get.width,
                      decoration: const BoxDecoration(
                          border: Border(
                              top:
                                  BorderSide(color: AppColor.grey300, width: 1),
                              bottom: BorderSide(
                                  color: AppColor.grey300, width: 1))),
                      selectedTextStyle: TextStyle(
                          fontSize: AppDimens.biggestTextSize,
                          color: AppColor.yellow,
                          fontWeight: FontWeight.bold),
                      textStyle: TextStyle(
                          fontSize: AppDimens.largeTextSize,
                          color: AppColor.primaryColor),
                      haptics: true,
                      maxValue: 10000,
                      minValue: 1,
                      value: controller.selectedGoal.value == 0
                          ? 1
                          : controller.selectedGoal.value,
                      onChanged: ((value) =>
                          controller.onSelectedGoalValue(value)),
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimens.mediumSpacingHor),
                child: RunButton(
                    buttonText: "Set as my goal",
                    onClick: () {
                      controller.onBackWithResult();
                    }),
              )
            ],
          )),
        ));
  }
}

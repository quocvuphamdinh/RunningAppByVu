import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/presentation/home/profile/run_history/pages/run_only_or_with_exercise_page.dart';
import 'package:running_app_flutter/presentation/home/profile/run_history/run_history_controller.dart';
import 'package:running_app_flutter/widgets/appbar/app_bar_with_bottom_tab.dart';
import 'package:running_app_flutter/widgets/core/text_title.dart';

class RunHistoryPage extends GetView<RunHistoryController> {
  const RunHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      body: SafeArea(
          child: AppBarWithBottomTab(
              widgetAppBarLeft: const TextTitle(text: "Your history run"),
              widgetAppBarRight: Text("Back",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.grey)),
              onCLickWidgetAppBarRight: () {
                Get.back();
              },
              widgetBodies: const [
            RunOnlyOrWithExercisePage(isRunWithExercise: false),
            RunOnlyOrWithExercisePage(isRunWithExercise: true),
          ],
              contentWidgetTabBars: [
            Text("Run Only",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
            Text("Run With Exercise",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
          ])),
    );
  }
}

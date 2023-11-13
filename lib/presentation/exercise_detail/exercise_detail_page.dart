import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/presentation/exercise_detail/exercise_detail_controller.dart';
import 'package:running_app_flutter/presentation/exercise_detail/widget/workout_item.dart';
import 'package:running_app_flutter/widgets/appbar/app_bar_three_side.dart';
import 'package:running_app_flutter/widgets/core/text_title.dart';

class ExerciseDetailPage extends GetView<ExerciseDetailController> {
  const ExerciseDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarThreeSide(
            widgetLeft: Icon(Icons.close, size: AppDimens.iconSmallSize),
            onClickWidgetLeft: () {
              Get.back();
            },
            widgetCenter: const TextTitle(text: "Week 1 Day 1"),
            widgetRight: Icon(Icons.play_arrow, size: AppDimens.iconSmallSize),
            onCLickWidgetRight: () {},
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppDimens.smallSpacingHor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: AppDimens.smallSpacingVer),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Workout",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      Text("Duration", style: TextStyle(fontSize: 16.sp))
                    ],
                  ),
                ),
                ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.workouts.length,
                      itemBuilder: ((context, index) {
                        return WorkoutItem(workout: controller.workouts[index]);
                      })),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}

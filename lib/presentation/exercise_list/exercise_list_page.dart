import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/constant/constant.dart';
import 'package:running_app_flutter/presentation/exercise_list/exercise_list_controller.dart';
import 'package:running_app_flutter/presentation/home/exercise/widget/exercise_item.dart';
import 'package:running_app_flutter/widgets/appbar/app_bar_two_side.dart';
import 'package:running_app_flutter/widgets/core/text_description.dart';
import 'package:running_app_flutter/widgets/core/text_title.dart';

class ExerciseListPage extends GetView<ExerciseListController> {
  const ExerciseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarTwoSide(
            widgetLeft: const TextTitle(text: "Training plans"),
            widgetRight: Icon(Icons.close, size: AppDimens.iconSmallSize),
            onCLickWidgetRight: () {
              Get.back();
              Get.delete<ExerciseListController>();
            },
          ),
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppDimens.smallSpacingHor),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextTitle(text: "Running App"),
                      TextDescription(text: "0/0")
                    ],
                  ),
                  Expanded(
                    child: Obx(() {
                      var exercises =
                          controller.exerciseType.value == Constant.WALKING
                              ? controller.walkingExercises
                              : controller.runningExercises;
                      return ListView.builder(
                          itemCount: exercises.length,
                          itemBuilder: ((context, index) {
                            return ExerciseItem(exerciseItem: exercises[index]);
                          }));
                    }),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
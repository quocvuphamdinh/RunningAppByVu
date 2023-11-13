import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/config/res/app_image.dart';
import 'package:running_app_flutter/presentation/result_exercise_run/result_exercise_run_controller.dart';
import 'package:running_app_flutter/presentation/result_exercise_run/widgets/result_run_data_row.dart';
import 'package:running_app_flutter/widgets/appbar/app_bar_three_side.dart';
import 'package:running_app_flutter/widgets/core/text_title.dart';

class ResultExerciseRunPage extends GetView<ResultExerciseRunController> {
  const ResultExerciseRunPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppBarThreeSide(
            widgetLeft: Icon(Icons.close, size: AppDimens.iconSmallSize),
            onClickWidgetLeft: () {
              Get.back();
            },
            widgetCenter:
                TextTitle(text: "Week 3 Day 1 - 10 mins - Running Exercise"),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppDimens.smallSpacingHor),
              child: Column(
                children: [
                  Container(
                    height: Get.height * 0.3,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            blurStyle: BlurStyle.solid,
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 5.0,
                          ),
                        ],
                        image: const DecorationImage(
                            image: AppImages.activityBackground,
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(10.r))),
                  ),
                  const ResultRunDataRow(
                    icon: AppImages.icMovingTimeColor,
                    titleText: "Start Time",
                    valueText: "08:52:38 hrs",
                    valueTextColor: AppColor.distanceColor,
                  ),
                  const ResultRunDataRow(
                    icon: AppImages.icDistanceColor,
                    titleText: "Distance",
                    valueText: "0.249 km",
                    valueTextColor: AppColor.distanceColor,
                  ),
                  const ResultRunDataRow(
                    icon: AppImages.icCaloriesColor,
                    titleText: "Calories Burned",
                    valueText: "19 Kcal",
                    valueTextColor: AppColor.caloriesColor,
                  ),
                  const ResultRunDataRow(
                    icon: AppImages.icAvgSpeedColor,
                    titleText: "Average Speed",
                    valueText: "16.1 km/h",
                    valueTextColor: AppColor.avgSpeedColor,
                  ),
                  const ResultRunDataRow(
                    icon: AppImages.icDurationColor,
                    titleText: "Duration",
                    valueText: "00:57 mins",
                    valueTextColor: AppColor.durationColor,
                  ),
                  ResultRunDataRow(
                    icon: AppImages.icCompleteRunColor,
                    titleText: "Completed",
                    isValueTextWidget: true,
                    valueTextWidget: Image(
                        image: AppImages.icCompleted,
                        width: AppDimens.iconSmallSize),
                  ),
                ],
              ),
            ),
          ))
        ],
      )),
    );
  }
}

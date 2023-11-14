import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/components/components.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/config/res/app_image.dart';
import 'package:running_app_flutter/constant/constant.dart';
import 'package:running_app_flutter/constant/data_run_types.dart';
import 'package:running_app_flutter/presentation/result_exercise_run/result_exercise_run_controller.dart';
import 'package:running_app_flutter/presentation/result_exercise_run/widgets/result_run_data_row.dart';
import 'package:running_app_flutter/widgets/appbar/app_bar_three_side.dart';
import 'package:running_app_flutter/widgets/core/run_button.dart';
import 'package:running_app_flutter/widgets/core/text_title.dart';

class ResultExerciseRunPage extends GetView<ResultExerciseRunController> {
  const ResultExerciseRunPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      body: SafeArea(
          child: Obx(() => controller.userActivityDetail.value != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppBarThreeSide(
                      widgetLeft:
                          Icon(Icons.close, size: AppDimens.iconSmallSize),
                      onClickWidgetLeft: () {
                        Get.back();
                      },
                      widgetCenter: TextTitle(
                          text:
                              "${controller.userActivityDetail.value!.activity.name} - ${Components.getFormattedTimerWithOption(ms: controller.userActivityDetail.value!.activity.durationOfWorkouts, option: OptionTimer.MINUTE)} mins - ${controller.userActivityDetail.value!.activity.type == Constant.WALKING ? "Walking" : "Running"} Exercise"),
                    ),
                    Expanded(
                        child: ScrollConfiguration(
                      behavior:
                          const ScrollBehavior().copyWith(overscroll: false),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppDimens.smallSpacingHor),
                              child: Column(
                                children: [
                                  SizedBox(height: AppDimens.size10),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.r))),
                                  ),
                                  ResultRunDataRow(
                                    icon: AppImages.icMovingTimeColor,
                                    titleText: "Start Time",
                                    valueText:
                                        "${Components.getFormattedTimer(ms: controller.userActivityDetail.value!.run.timestamp - controller.userActivityDetail.value!.run.timeInMillis, includeHour: true, includeMinute: true, includeSecond: true)} hrs",
                                    valueTextColor: AppColor.distanceColor,
                                  ),
                                  ResultRunDataRow(
                                    icon: AppImages.icDistanceColor,
                                    titleText: "Distance",
                                    valueText:
                                        "${controller.userActivityDetail.value!.run.distanceInKilometers / 1000} km",
                                    valueTextColor: AppColor.distanceColor,
                                  ),
                                  ResultRunDataRow(
                                    icon: AppImages.icCaloriesColor,
                                    titleText: "Calories Burned",
                                    valueText:
                                        "${controller.userActivityDetail.value!.run.caloriesBurned} Kcal",
                                    valueTextColor: AppColor.caloriesColor,
                                  ),
                                  ResultRunDataRow(
                                    icon: AppImages.icAvgSpeedColor,
                                    titleText: "Average Speed",
                                    valueText:
                                        "${controller.userActivityDetail.value!.run.averageSpeedInKilometersPerHour} km/h",
                                    valueTextColor: AppColor.avgSpeedColor,
                                  ),
                                  ResultRunDataRow(
                                    icon: AppImages.icDurationColor,
                                    titleText: "Duration",
                                    valueText:
                                        "${Components.getFormattedTimer(ms: controller.userActivityDetail.value!.run.timeInMillis, includeHour: true, includeMinute: true)} mins",
                                    valueTextColor: AppColor.durationColor,
                                  ),
                                  ResultRunDataRow(
                                    icon: AppImages.icCompleteRunColor,
                                    titleText: "Completed",
                                    isValueTextWidget: true,
                                    valueTextWidget: Image(
                                        image: controller
                                                    .userActivityDetail
                                                    .value!
                                                    .activity
                                                    .isCompleted ==
                                                1
                                            ? AppImages.icCompleted
                                            : AppImages.icNotCompleted,
                                        width: AppDimens.iconSmallSize),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: AppDimens.size5,
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                colors: [
                                  AppColor.durationColor,
                                  AppColor.avgSpeedColor,
                                  AppColor.caloriesColor
                                ],
                              )),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: AppDimens.smallSpacingVer,
                                  horizontal: AppDimens.smallSpacingHor),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Add note",
                                      style: TextStyle(fontSize: 16.sp)),
                                  TextFormField(
                                    style: TextStyle(fontSize: 16.sp),
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColor.primaryColor),
                                        ),
                                        prefixIcon: Icon(Icons.edit,
                                            color: AppColor.grey,
                                            size: AppDimens.iconSmallSize)),
                                    controller:
                                        controller.textAddNoteController,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: AppDimens.mediumSpacingVer,
                                        bottom: AppDimens.smallSpacingVer),
                                    child: Text(
                                      "How do you feel ?",
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.onClickChangeMood(
                                                Constant.SMILING_MOOD);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.h),
                                            decoration: BoxDecoration(
                                                color: controller
                                                            .userActivityDetail
                                                            .value!
                                                            .mood ==
                                                        Constant.SMILING_MOOD
                                                    ? AppColor.grey80
                                                    : AppColor.whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(8.r)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Image(
                                                    image: AppImages.icSmiling),
                                                SizedBox(
                                                  height: AppDimens.size5,
                                                ),
                                                Text("Easy",
                                                    style: TextStyle(
                                                        fontSize: 20.sp))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.onClickChangeMood(
                                                Constant.NOT_SMILING_MOOD);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: controller
                                                            .userActivityDetail
                                                            .value!
                                                            .mood ==
                                                        Constant
                                                            .NOT_SMILING_MOOD
                                                    ? AppColor.grey80
                                                    : AppColor.whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(8.r)),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.h),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Image(
                                                    image:
                                                        AppImages.icNotSmiling),
                                                SizedBox(
                                                  height: AppDimens.size5,
                                                ),
                                                Text("Perfect",
                                                    style: TextStyle(
                                                        fontSize: 20.sp))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.onClickChangeMood(
                                                Constant.TIRED_MOOD);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: controller
                                                            .userActivityDetail
                                                            .value!
                                                            .mood ==
                                                        Constant.TIRED_MOOD
                                                    ? AppColor.grey80
                                                    : AppColor.whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(8.r)),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.h),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Image(
                                                    image: AppImages.icTired),
                                                SizedBox(
                                                  height: AppDimens.size5,
                                                ),
                                                Text("Exhausted",
                                                    style: TextStyle(
                                                        fontSize: 20.sp))
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: AppDimens.size20,
                                  ),
                                  RunButton(
                                      buttonText: "Save",
                                      onClick: () {},
                                      backgroundColor: AppColor.grey80),
                                  SizedBox(
                                    height: AppDimens.size10,
                                  ),
                                  RunButton(
                                      buttonText: "Delete",
                                      onClick: () {},
                                      backgroundColor: AppColor.redColor)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
                  ],
                )
              : Center(
                  child: Text("No data to show",
                      style: TextStyle(fontSize: AppDimens.largeTextSize)),
                ))),
    );
  }
}

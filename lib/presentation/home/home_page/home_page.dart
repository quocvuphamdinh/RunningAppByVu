import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:running_app_flutter/components/components.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/config/res/app_image.dart';
import 'package:running_app_flutter/constant/constant.dart';
import 'package:running_app_flutter/presentation/home/home_page/widget/best_record_card.dart';
import 'package:running_app_flutter/presentation/home/home_page/widget/progress_today_card.dart';
import 'package:running_app_flutter/presentation/home/home_page/widget/progress_weekly.dart';
import 'package:running_app_flutter/presentation/home/home_page/widget/recent_activity_item.dart';
import 'package:running_app_flutter/presentation/home/home_page/widget/today_training_card.dart';
import 'package:running_app_flutter/routes/app_routes.dart';
import 'package:running_app_flutter/widgets/appbar/app_bar_two_side.dart';
import 'package:running_app_flutter/presentation/home/home_page/home_controller.dart';
import 'package:running_app_flutter/widgets/core/run_text_no_data.dart';
import 'package:running_app_flutter/widgets/core/text_description.dart';
import 'package:running_app_flutter/widgets/core/text_more.dart';
import 'package:running_app_flutter/widgets/core/text_title.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarTwoSide(
                widgetLeft: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextTitle(
                      text: "Running App",
                    ),
                    Expanded(
                      child: Obx(() => RichText(
                            text: TextSpan(
                                text: "Let's go ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.primaryColor,
                                    fontSize: 16.sp,
                                    fontStyle: FontStyle.italic),
                                children: [
                                  TextSpan(
                                      text: controller.user.value?.fullName,
                                      style: TextStyle(
                                          color: AppColor.textPrimaryColor,
                                          fontSize: 16.sp,
                                          fontStyle: FontStyle.italic))
                                ]),
                          )),
                    )
                  ],
                ),
                onCLickWidgetRight: () {
                  controller.goToSetMyGoal();
                },
                widgetRight: Icon(
                  Icons.info_outline,
                  size: AppDimens.iconMediumSize,
                  color: AppColor.primaryColor,
                ),
              ),
              Expanded(
                child: SmartRefresher(
                  onRefresh: controller.onRefresh,
                  controller: controller.refreshController,
                  header: const WaterDropHeader(
                    refresh: CupertinoActivityIndicator(),
                    complete: Icon(Icons.check, color: AppColor.grey),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppDimens.aBitSpacingHor),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: AppDimens.mediumSpacingVer),
                                child: Obx(() => ProgressWeekly(
                                      weeklyGoal:
                                          controller.user.value?.distanceGoal,
                                      distance:
                                          controller.totalDistanceWeekly.value,
                                    ))),
                          ),
                          const TextDescription(text: "Your progress today"),
                          Padding(
                            padding: EdgeInsets.only(
                              top: AppDimens.smallSpacingVer,
                            ),
                            child: GridView.count(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisSpacing: 20.w,
                              mainAxisSpacing: 20.h,
                              crossAxisCount: 2,
                              childAspectRatio: (Get.width / 2) / 60.h,
                              children: [
                                Obx(() => ProgressTodayCard(
                                    image: AppImages.icCaloriesBurn,
                                    value: controller.totalCalories.value,
                                    unitType: "Kcl")),
                                Obx(() => ProgressTodayCard(
                                    image: AppImages.icMilies,
                                    value: Components.getFormattedTimer(
                                        ms: controller.totalRunMillies.value,
                                        includeHour: true,
                                        includeMinute: true,
                                        includeSecond: true),
                                    unitType: "H:M:S")),
                                Obx(() => ProgressTodayCard(
                                    image: AppImages.icRun,
                                    value: controller.totalAvgSpeed.value == 0
                                        ? 0
                                        : controller.totalAvgSpeed.value
                                            .toStringAsFixed(2),
                                    unitType: "Km/h")),
                                Obx(() => ProgressTodayCard(
                                    image: AppImages.icRunCount,
                                    value: controller.totalRun.value,
                                    unitType: "Run/day"))
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const TextDescription(text: "Today's training"),
                              Obx(() => controller.todayTraninings.isNotEmpty
                                  ? GestureDetector(
                                      child: const TextMore(),
                                      onTap: () {
                                        Get.toNamed(AppRoutes.ExerciseList,
                                            arguments: {
                                              Constant.EXERCISE_TYPE:
                                                  Constant.RUNNING,
                                              Constant.EXERCISE_TITLE:
                                                  "Running for today training"
                                            });
                                      },
                                    )
                                  : const SizedBox()),
                            ],
                          ),
                          Obx(() => !controller.isLoadingTodayTraining.value
                              ? (controller.todayTraninings.isNotEmpty
                                  ? Container(
                                      margin: EdgeInsets.only(
                                          top: AppDimens.smallSpacingVer,
                                          bottom: AppDimens.mediumSpacingVer),
                                      height: 250.h,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              controller.todayTraninings.length,
                                          itemBuilder: ((context, index) {
                                            return InkWell(
                                                onTap: () {
                                                  Get.toNamed(
                                                      AppRoutes.ExerciseDetail,
                                                      arguments: {
                                                        'exercise': controller
                                                                .todayTraninings[
                                                            index]
                                                      });
                                                },
                                                child: TodayTrainingCard(
                                                    exercise: controller
                                                        .todayTraninings[index],
                                                    index: index));
                                          })),
                                    )
                                  : const RunTextNoData())
                              : const Center(
                                  child: CupertinoActivityIndicator())),
                          Padding(
                            padding:
                                EdgeInsets.only(top: AppDimens.aBitSpacingHor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const TextDescription(
                                    text: "Recent activities"),
                                Obx(() => controller.recentActivites.isNotEmpty
                                    ? GestureDetector(
                                        child: const TextMore(),
                                        onTap: () {
                                          Get.toNamed(AppRoutes.RecentExercise);
                                        })
                                    : const SizedBox()),
                              ],
                            ),
                          ),
                          Obx(() => controller.recentActivites.isNotEmpty
                              ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.recentActivites.length,
                                  itemBuilder: ((context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.ResultExerciseRun,
                                            arguments: {
                                              'result_exercise_run': controller
                                                  .recentActivites[index]
                                            });
                                      },
                                      child: RecentActivityItem(
                                          recentActivity: controller
                                              .recentActivites[index]),
                                    );
                                  }))
                              : const RunTextNoData()),
                          Text(
                            "Best records",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontFamily: "OsWald",
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: AppDimens.smallSpacingVer),
                            height: 200.h,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Obx(() => BestRecordCard(
                                            image: AppImages.icRoad,
                                            textValue:
                                                "${controller.longestDistance.value / 1000} km",
                                            description: "Longest distance",
                                          )),
                                    ),
                                    SizedBox(
                                      width: AppDimens.size20,
                                    ),
                                    Expanded(
                                      child: Obx(() => BestRecordCard(
                                          image: AppImages.icLongestDuration,
                                          textValue:
                                              Components.getFormattedTimer(
                                                  ms: controller
                                                      .longestDuration.value,
                                                  includeHour: true,
                                                  includeMinute: true,
                                                  includeSecond: true),
                                          description: "Longest duration")),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: AppDimens.size10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              AppDimens.mediumSpacingHor,
                                          vertical: AppDimens.smallSpacingVer),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        color: AppColor.grey90,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Image(
                                                  image: AppImages
                                                      .icBestCaloriesBurned,
                                                  width:
                                                      AppDimens.iconSmallSize),
                                              SizedBox(width: AppDimens.size10),
                                              Text(
                                                "Best calories burned",
                                                style: TextStyle(
                                                    color:
                                                        AppColor.primaryColor,
                                                    fontSize:
                                                        AppDimens.largeTextSize,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left:
                                                    AppDimens.mediumSpacingHor,
                                                top: 4.h),
                                            child: Obx(() => Text(
                                                  "${controller.bestCalories.value} kcal",
                                                  style: TextStyle(
                                                      color: AppColor.yellow,
                                                      fontSize: AppDimens
                                                          .largeTextSize,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ))
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
                    RichText(
                      text: TextSpan(
                          text: "Let's go ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColor.primaryColor,
                              fontSize: 16.sp,
                              fontStyle: FontStyle.italic),
                          children: [
                            TextSpan(
                                text: "Phạm Đình Quốc Vũ",
                                style: TextStyle(
                                    color: AppColor.textPrimaryColor,
                                    fontSize: 16.sp,
                                    fontStyle: FontStyle.italic))
                          ]),
                    )
                  ],
                ),
                onCLickWidgetRight: () {
                  Get.toNamed(AppRoutes.WeeklyGoalSetting);
                },
                widgetRight: Icon(
                  Icons.info_outline,
                  size: AppDimens.iconMediumSize,
                  color: AppColor.primaryColor,
                ),
              ),
              Expanded(
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
                              child: ProgressWeekly()),
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
                            children: const [
                              ProgressTodayCard(
                                  image: AppImages.icCaloriesBurn,
                                  value: 0,
                                  unitType: "Kcl"),
                              ProgressTodayCard(
                                  image: AppImages.icMilies,
                                  value: 1,
                                  unitType: "Milies"),
                              ProgressTodayCard(
                                  image: AppImages.icRun,
                                  value: 2,
                                  unitType: "Km/h"),
                              ProgressTodayCard(
                                  image: AppImages.icRunCount,
                                  value: 3,
                                  unitType: "Run/day")
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TextDescription(text: "Today's training"),
                            GestureDetector(
                              child: const TextMore(),
                              onTap: () {
                                Get.toNamed(AppRoutes.ExerciseList, arguments: {
                                  Constant.EXERCISE_TYPE: Constant.RUNNING,
                                  Constant.EXERCISE_TITLE:
                                      "Running for today training"
                                });
                              },
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: AppDimens.smallSpacingVer,
                              bottom: AppDimens.mediumSpacingVer),
                          height: 250.h,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: ((context, index) {
                                return InkWell(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.ExerciseDetail);
                                    },
                                    child: TodayTrainingCard(index: index));
                              })),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TextDescription(text: "Recent activities"),
                            GestureDetector(
                                child: const TextMore(),
                                onTap: () {
                                  Get.toNamed(AppRoutes.RecentExercise);
                                }),
                          ],
                        ),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 2,
                            itemBuilder: ((context, index) {
                              return InkWell(
                                onTap: () {
                                  Get.toNamed(AppRoutes.ResultExerciseRun);
                                },
                                child: RecentActivityItem(
                                    recentActivity:
                                        controller.recentActivites[index]),
                              );
                            })),
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
                                  const Expanded(
                                    child: BestRecordCard(
                                      image: AppImages.icRoad,
                                      textValue: "0.249 km",
                                      description: "Longest distance",
                                    ),
                                  ),
                                  SizedBox(
                                    width: AppDimens.size20,
                                  ),
                                  const Expanded(
                                    child: BestRecordCard(
                                        image: AppImages.icLongestDuration,
                                        textValue: "00:00:57",
                                        description: "Longest duration"),
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
                                        horizontal: AppDimens.mediumSpacingHor,
                                        vertical: AppDimens.smallSpacingVer),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r),
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
                                                width: AppDimens.iconSmallSize),
                                            SizedBox(width: AppDimens.size10),
                                            Text(
                                              "Best calories burned",
                                              style: TextStyle(
                                                  color: AppColor.primaryColor,
                                                  fontSize:
                                                      AppDimens.largeTextSize,
                                                  fontWeight: FontWeight.w800),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: AppDimens.mediumSpacingHor,
                                              top: 4.h),
                                          child: Text(
                                            "19 kcal",
                                            style: TextStyle(
                                                color: AppColor.yellow,
                                                fontSize:
                                                    AppDimens.largeTextSize,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic),
                                          ),
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
              )
            ],
          )),
    );
  }
}

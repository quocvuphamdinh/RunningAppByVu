import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/config/res/app_image.dart';
import 'package:running_app_flutter/presentation/home/home_page/widget/progress_today_card.dart';
import 'package:running_app_flutter/presentation/home/home_page/widget/recent_activity_item.dart';
import 'package:running_app_flutter/presentation/home/home_page/widget/today_training_card.dart';
import 'package:running_app_flutter/widgets/appbar/app_bar_two_side.dart';
import 'package:running_app_flutter/presentation/home/home_page/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarTwoSide(
            widgetLeft: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Running app",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryColor,
                      fontSize: 20.sp,
                      fontFamily: "OsWald"),
                ),
                RichText(
                  text: TextSpan(
                      text: "Let's go ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryColor,
                          fontSize: AppDimens.mediumTextSize,
                          fontStyle: FontStyle.italic),
                      children: [
                        TextSpan(
                            text: "Phạm Đình Quốc Vũ",
                            style: TextStyle(
                                color: AppColor.textPrimaryColor,
                                fontSize: AppDimens.mediumTextSize,
                                fontStyle: FontStyle.italic))
                      ]),
                )
              ],
            ),
            onCLickWidgetRight: () {},
            widgetRight: Icon(
              Icons.info_outline,
              size: AppDimens.iconMediumSize,
              color: AppColor.primaryColor,
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppDimens.aBitSpacingHor),
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: AppDimens.mediumSpacingVer),
                          child: CircularPercentIndicator(
                            radius: 110.0.r,
                            lineWidth: 20.0,
                            percent: 0.8,
                            center: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Distance",
                                  style: TextStyle(
                                      fontSize: 25.sp,
                                      fontFamily: "OsWald",
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.primaryColor),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: AppDimens.smallSpacingVer),
                                  child: RichText(
                                      text: TextSpan(
                                          text: "0.0",
                                          style: TextStyle(
                                              fontSize: 30.sp,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              color: AppColor.primaryColor),
                                          children: [
                                        TextSpan(
                                            text: " km",
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.primaryColor,
                                              fontStyle: FontStyle.italic,
                                            ))
                                      ])),
                                ),
                                Text(
                                  "Weekly goal 1km",
                                  style: TextStyle(
                                      fontSize: AppDimens.smallTextSize),
                                )
                              ],
                            ),
                            backgroundColor: AppColor.grey100,
                            linearGradient: const LinearGradient(colors: [
                              AppColor.startColor,
                              AppColor.centerColor,
                              AppColor.endColor
                            ]),
                          ),
                        ),
                      ),
                      Text(
                        "Your progress today",
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontFamily: "OsWald",
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: AppDimens.smallSpacingVer,
                            bottom: AppDimens.mediumSpacingVer),
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
                          Text(
                            "Today's training",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontFamily: "OsWald",
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "More",
                            style: TextStyle(
                                color: AppColor.yellow,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp),
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
                              return TodayTrainingCard(index: index);
                            })),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recent activities",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontFamily: "OsWald",
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "More",
                            style: TextStyle(
                                color: AppColor.yellow,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp),
                          ),
                        ],
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 2,
                          itemBuilder: ((context, index) {
                            return RecentActivityItem(
                                recentActivityModel:
                                    controller.recentActivites[index]);
                          }))
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

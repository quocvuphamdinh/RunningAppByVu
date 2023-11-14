import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/components/components.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/config/res/app_image.dart';
import 'package:running_app_flutter/presentation/home/home_page/recent_exercise/recent_exercise_controller.dart';
import 'package:running_app_flutter/presentation/home/home_page/widget/recent_activity_item.dart';
import 'package:running_app_flutter/routes/app_routes.dart';
import 'package:running_app_flutter/widgets/appbar/app_bar_two_side.dart';

class RecentExercisePage extends GetView<RecentExerciseController> {
  const RecentExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            height: Get.height * 0.3,
            child: Container(
              color: AppColor.primaryColor.withOpacity(0.5),
              height: Get.height * 0.3,
            ),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AppImages.recentExerciseBackground)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarTwoSide(
                backgroundColor: Colors.transparent,
                widgetLeft: Icon(Icons.close,
                    size: AppDimens.iconSmallSize, color: AppColor.whiteColor),
                onClickWidgetLeft: () {
                  Get.back();
                },
              ),
              Obx(() => Container(
                    padding: EdgeInsets.only(
                        left: AppDimens.mediumSpacingHor,
                        right: AppDimens.mediumSpacingHor,
                        bottom: AppDimens.smallSpacingVer),
                    height: Get.height * 0.3 - 65.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${controller.totalKm.value}",
                          style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColor.whiteColor),
                        ),
                        Text("TOTAL KM",
                            style: TextStyle(
                                color: AppColor.whiteColor,
                                fontSize: AppDimens.mediumTextSize)),
                        SizedBox(height: AppDimens.size10),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Components.getFormattedTimer(
                                        ms: controller.totalDuration.value,
                                        includeHour: true,
                                        includeMinute: true,
                                        includeSecond: true),
                                    style: TextStyle(
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.whiteColor),
                                  ),
                                  Text("TOTAL\nDURATIONS",
                                      style: TextStyle(
                                          color: AppColor.whiteColor,
                                          fontSize: AppDimens.mediumTextSize))
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${controller.totalCalories.value}",
                                    style: TextStyle(
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.whiteColor),
                                  ),
                                  Text("TOTAL\nKCAL",
                                      style: TextStyle(
                                          color: AppColor.whiteColor,
                                          fontSize: AppDimens.mediumTextSize))
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${controller.totalAvgSpeed.value}",
                                    style: TextStyle(
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.whiteColor),
                                  ),
                                  Text("TOTAL AVG\nSPEED",
                                      style: TextStyle(
                                          color: AppColor.whiteColor,
                                          fontSize: AppDimens.mediumTextSize))
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
              Expanded(
                  child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppDimens.smallSpacingHor),
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: ListView.builder(
                      itemCount: controller.recentActivites.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.ResultExerciseRun);
                          },
                          child: RecentActivityItem(
                              recentActivity:
                                  controller.recentActivites[index]),
                        );
                      })),
                ),
              ))
            ],
          )
        ],
      )),
    );
  }
}

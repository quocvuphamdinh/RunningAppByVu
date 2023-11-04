import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/config/res/app_image.dart';

class RecentActivityModel {
  final int activityType;
  final ImageProvider? iconStatus;
  final String title;
  final String runDateTime;
  final double distance;
  final String runTime;
  final double averageSpeed;
  final int caloriesBurned;

  RecentActivityModel(
      {required this.activityType,
      this.iconStatus,
      required this.title,
      required this.runDateTime,
      required this.distance,
      required this.runTime,
      required this.averageSpeed,
      required this.caloriesBurned});
}

class RecentActivityItem extends StatelessWidget {
  const RecentActivityItem({super.key, required this.recentActivityModel});
  final RecentActivityModel recentActivityModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      height: 100.h,
      child: Row(
        children: [
          Container(
            child: Container(
              color: AppColor.primaryColor.withOpacity(0.5),
              height: 100.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    recentActivityModel.title,
                    style: TextStyle(
                        fontSize: AppDimens.mediumTextSize,
                        color: AppColor.whiteColor),
                  )
                ],
              ),
            ),
            width: Get.width * 0.3,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: recentActivityModel.activityType == 1
                        ? AppImages.activityBackground
                        : AppImages.walkingBackground)),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: AppDimens.mediumSpacingHor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      recentActivityModel.runDateTime,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryColor,
                          fontSize: AppDimens.largeTextSize),
                    ),
                    recentActivityModel.iconStatus != null
                        ? Image(
                            image: recentActivityModel.iconStatus!,
                            width: AppDimens.iconSmallSize,
                          )
                        : const SizedBox()
                  ],
                ),
                Text(
                  "${recentActivityModel.distance} km",
                  style: TextStyle(
                      fontFamily: "OsWald",
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryColor,
                      fontSize: 24.sp,
                      fontStyle: FontStyle.italic),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      recentActivityModel.runTime,
                      style: TextStyle(fontSize: AppDimens.mediumTextSize),
                    ),
                    Text("${recentActivityModel.averageSpeed} kph",
                        style: TextStyle(fontSize: AppDimens.mediumTextSize)),
                    Text("${recentActivityModel.caloriesBurned} kcal",
                        style: TextStyle(fontSize: AppDimens.mediumTextSize))
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}

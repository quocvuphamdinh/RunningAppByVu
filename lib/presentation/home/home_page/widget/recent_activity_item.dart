import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:running_app_flutter/components/components.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/config/res/app_image.dart';
import 'package:running_app_flutter/constant/constant.dart';
import 'package:running_app_flutter/models/user_activity_detail.dart';

class RecentActivityItem extends StatelessWidget {
  const RecentActivityItem({super.key, required this.recentActivity});
  final UserActivityDetail recentActivity;

  @override
  Widget build(BuildContext context) {
    var dateFormat = DateFormat('MMM');
    var dateRun = DateTime.fromMillisecondsSinceEpoch(
        recentActivity.run.timestamp * 1000,
        isUtc: true);
    print("dateRun: $dateRun");
    var runDuration = Components.getFormattedTimer(
        ms: recentActivity.run.timeInMillis,
        includeHour: true,
        includeMinute: true,
        includeSecond: true);
    print("dateRun: $runDuration");
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
                    recentActivity.activity.name,
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
                    image: recentActivity.activity.type == 1
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
                      "${dateFormat.format(dateRun)} ${dateRun.day}, ${Components.convertDateTimeToString(dateTime: dateRun, dateFormat: "HH:mm")}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryColor,
                          fontSize: AppDimens.largeTextSize),
                    ),
                    recentActivity.mood != null
                        ? Image(
                            image: recentActivity.mood! == Constant.SMILING_MOOD
                                ? AppImages.icSmiling
                                : (recentActivity.mood! ==
                                        Constant.NOT_SMILING_MOOD
                                    ? AppImages.icNotSmiling
                                    : AppImages.icTired),
                            width: AppDimens.iconSmallSize,
                          )
                        : const SizedBox()
                  ],
                ),
                Text(
                  "${recentActivity.run.distanceInKilometers / 1000} km",
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
                      runDuration,
                      style: TextStyle(fontSize: AppDimens.mediumTextSize),
                    ),
                    Text(
                        "${recentActivity.run.averageSpeedInKilometersPerHour} kph",
                        style: TextStyle(fontSize: AppDimens.mediumTextSize)),
                    Text("${recentActivity.run.caloriesBurned} kcal",
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

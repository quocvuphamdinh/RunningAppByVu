import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/components/components.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/config/res/app_image.dart';
import 'package:running_app_flutter/constant/constant.dart';
import 'package:running_app_flutter/data/models/activity.dart';

class TodayTrainingCard extends StatelessWidget {
  const TodayTrainingCard(
      {super.key, required this.index, required this.exercise});
  final int index;
  final Activity exercise;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: index < 4 ? 20.w : 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          image: DecorationImage(
              image: exercise.type == Constant.RUNNING
                  ? AppImages.activityBackground
                  : AppImages.walkingBackground,
              fit: BoxFit.cover)),
      width: Get.width * 0.8,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppDimens.mediumSpacingHor,
            vertical: AppDimens.mediumSpacingVer),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              exercise.name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppDimens.headerTitleSize,
                  color: AppColor.primaryColor),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.timer, size: AppDimens.iconSmallSize),
                SizedBox(width: AppDimens.aBitSpacingHor),
                Text(
                  Components.getFormattedTimer(ms: exercise.durationOfWorkouts),
                  style: TextStyle(fontSize: AppDimens.largeTextSize),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

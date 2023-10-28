import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/config/res/app_image.dart';

class TodayTrainingCard extends StatelessWidget {
  const TodayTrainingCard({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: index < 4 ? 20.w : 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          image: const DecorationImage(
              image: AppImages.activityBackground, fit: BoxFit.cover)),
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
              "Week 1",
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
                Text(
                  "18 min",
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

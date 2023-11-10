import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/config/res/app_image.dart';

class ExerciseItemModel {
  final int activityType;
  final String title;
  final int minuteNumber;

  ExerciseItemModel(
      {required this.activityType,
      required this.title,
      required this.minuteNumber});
}

class ExerciseItem extends StatelessWidget {
  const ExerciseItem({super.key, required this.exerciseItem});

  final ExerciseItemModel exerciseItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.only(bottom: AppDimens.smallSpacingVer),
      height: 95.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(right: AppDimens.smallSpacingHor),
              width: Get.width * 0.3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: exerciseItem.activityType == 1
                          ? AppImages.activityBackground
                          : AppImages.walkingBackground))),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  exerciseItem.title,
                  style: TextStyle(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimens.largeTextSize),
                ),
                SizedBox(
                  height: AppDimens.size20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.timer,
                      size: AppDimens.iconSmallSize,
                      color: AppColor.grey,
                    ),
                    Text(
                      "${exerciseItem.minuteNumber} min",
                      style: TextStyle(fontSize: AppDimens.mediumTextSize),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

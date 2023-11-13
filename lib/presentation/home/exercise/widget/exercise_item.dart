import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/components/components.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/config/res/app_image.dart';
import 'package:running_app_flutter/constant/constant.dart';
import 'package:running_app_flutter/constant/data_run_types.dart';
import 'package:running_app_flutter/models/activity.dart';

class ExerciseItem extends StatelessWidget {
  const ExerciseItem({super.key, required this.exerciseItem});

  final Activity exerciseItem;

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
                      image: exerciseItem.type == Constant.RUNNING
                          ? AppImages.activityBackground
                          : AppImages.walkingBackground))),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  exerciseItem.name,
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
                      "${Components.getFormattedTimerWithOption(ms: exerciseItem.durationOfWorkouts, option: OptionTimer.MINUTE)} min",
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

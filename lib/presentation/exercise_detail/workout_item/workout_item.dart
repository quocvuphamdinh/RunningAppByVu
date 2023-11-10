import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:running_app_flutter/components/components.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/config/res/app_image.dart';
import 'package:running_app_flutter/models/workout.dart';

class WorkoutItem extends StatelessWidget {
  const WorkoutItem({super.key, required this.workout});

  final Workout workout;

  Widget getIconByWorkout(String name) {
    if (name == "Walk") {
      return Icon(Icons.directions_walk, size: AppDimens.iconSmallSize);
    } else if (name == "Run") {
      return Image(image: AppImages.icRun, width: AppDimens.iconSmallSize);
    } else {
      return Image(image: AppImages.icCoolDown, width: AppDimens.iconSmallSize);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: AppDimens.smallSpacingVer),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getIconByWorkout(workout.name),
          SizedBox(width: AppDimens.size20),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(workout.name,
                    style: TextStyle(
                        color: AppColor.primaryColor, fontSize: 16.sp)),
                Text(Components.getFormattedTimer(ms: workout.duration),
                    style: TextStyle(fontSize: 16.sp))
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';

class ProgressWeekly extends StatelessWidget {
  const ProgressWeekly({super.key, this.distance = 0, this.weeklyGoal = 0});

  final int? distance;
  final int? weeklyGoal;

  @override
  Widget build(BuildContext context) {
    var percent = (distance == 0 || distance == null)
        ? 0.0
        : (distance!) /
            (((weeklyGoal ?? 0) == 0 || ((weeklyGoal ?? 0) * 1000) <= distance!)
                ? distance!
                : (weeklyGoal ?? 0) * 1000);
    print("Percent: $percent");
    return CircularPercentIndicator(
      radius: 110.0.r,
      lineWidth: 20.0,
      percent: percent,
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
            padding: EdgeInsets.symmetric(vertical: AppDimens.smallSpacingVer),
            child: RichText(
                text: TextSpan(
                    text: ((distance ?? 0) / 1000).toString(),
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
            "Weekly goal ${weeklyGoal}km",
            style: TextStyle(fontSize: AppDimens.smallTextSize),
          )
        ],
      ),
      backgroundColor: AppColor.grey100,
      linearGradient: const LinearGradient(colors: [
        AppColor.startColor,
        AppColor.centerColor,
        AppColor.endColor
      ]),
    );
  }
}

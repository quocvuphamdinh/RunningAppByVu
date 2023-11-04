import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';

class ProgressWeekly extends StatelessWidget {
  const ProgressWeekly({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
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
            padding: EdgeInsets.symmetric(vertical: AppDimens.smallSpacingVer),
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

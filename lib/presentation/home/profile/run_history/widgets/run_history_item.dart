import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:running_app_flutter/components/components.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/config/res/app_image.dart';
import 'package:running_app_flutter/models/run.dart';

class RunHistoryItem extends StatelessWidget {
  const RunHistoryItem({super.key, required this.run});

  final Run run;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColor.whiteColor, boxShadow: [
        BoxShadow(
          blurStyle: BlurStyle.solid,
          color: Colors.grey,
          offset: Offset(0.0, 1.0), //(x,y)
          blurRadius: 6.0,
        ),
      ]),
      margin: EdgeInsets.only(bottom: AppDimens.mediumSpacingVer),
      height: 150.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(flex: 1, child: Image(image: AppImages.logoImage)),
          Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(
                    left: AppDimens.smallSpacingHor, right: 30.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              Components.convertDateTimeToString(
                                  dateTime: DateTime.fromMillisecondsSinceEpoch(
                                      run.timestamp * 1000,
                                      isUtc: true),
                                  dateFormat: 'dd/MM/yyyy'),
                              style: TextStyle(fontSize: 16.sp)),
                          Text("${run.averageSpeedInKilometersPerHour} km/h",
                              style: TextStyle(fontSize: 16.sp))
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${run.distanceInKilometers / 1000} km",
                              style: TextStyle(fontSize: 16.sp)),
                          Text(
                              Components.getFormattedTimer(
                                  ms: run.timeInMillis,
                                  includeHour: true,
                                  includeMinute: true,
                                  includeSecond: true),
                              style: TextStyle(fontSize: 16.sp))
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${run.caloriesBurned} kcal",
                              style: TextStyle(fontSize: 16.sp)),
                          Text(
                              Components.convertDateTimeToString(
                                  dateTime: DateTime.fromMillisecondsSinceEpoch(
                                      run.timestamp * 1000,
                                      isUtc: true),
                                  dateFormat: "hh:mm:ss"),
                              style: TextStyle(fontSize: 16.sp))
                        ])
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

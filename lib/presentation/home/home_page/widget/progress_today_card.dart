import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';

class ProgressTodayCard extends StatelessWidget {
  const ProgressTodayCard(
      {super.key,
      required this.image,
      required this.value,
      required this.unitType});

  final ImageProvider image;
  final dynamic value;
  final String unitType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.grey90, borderRadius: BorderRadius.circular(8.r)),
      child: Row(
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppDimens.mediumSpacingHor),
            child: Image(image: image, width: 30.w, height: 30.h),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$value",
                style: TextStyle(
                    fontSize: AppDimens.largeTextSize,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor),
              ),
              Text(
                unitType,
                style: TextStyle(
                    color: AppColor.textPrimaryColor,
                    fontSize: AppDimens.mediumTextSize),
              )
            ],
          )
        ],
      ),
    );
  }
}

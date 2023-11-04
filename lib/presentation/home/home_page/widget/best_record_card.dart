import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';

class BestRecordCard extends StatelessWidget {
  const BestRecordCard(
      {super.key,
      required this.image,
      required this.textValue,
      required this.description});

  final ImageProvider image;
  final String textValue;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r), color: AppColor.grey90),
      padding: EdgeInsets.symmetric(
          horizontal: AppDimens.mediumSpacingHor,
          vertical: AppDimens.smallSpacingVer),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: image,
            width: AppDimens.iconSmallSize,
          ),
          Text(
            textValue,
            style: TextStyle(
                color: AppColor.yellow,
                fontSize: AppDimens.largeTextSize,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
          Text(
            description,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.primaryColor,
                fontSize: AppDimens.mediumTextSize),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/config/res/app_image.dart';

class RunBottomAppBar extends StatelessWidget {
  const RunBottomAppBar({super.key, required this.onArrowClick});

  final Function()? onArrowClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: AppDimens.aBitSpacingHor,
          horizontal: AppDimens.mediumSpacingHor),
      decoration: const BoxDecoration(color: AppColor.primaryColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onArrowClick,
            child: const Icon(Icons.arrow_back_ios,
                color: AppColor.textPrimaryColor),
          ),
          Image(
            fit: BoxFit.fill,
            image: AppImages.runnerWhiteImage,
            width: 40.w,
            height: 30.h,
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';

class AppBarThreeSide extends StatelessWidget {
  const AppBarThreeSide(
      {super.key,
      this.widgetLeft,
      this.onClickWidgetLeft,
      this.onClickWidgetCenter,
      this.onCLickWidgetRight,
      this.widgetRight,
      this.widgetCenter});

  final Widget? widgetLeft;
  final Widget? widgetCenter;
  final Widget? widgetRight;
  final Function()? onClickWidgetLeft;
  final Function()? onClickWidgetCenter;
  final Function()? onCLickWidgetRight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimens.aBitSpacingHor),
      height: 65.h,
      color: AppColor.appBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widgetLeft != null
              ? GestureDetector(
                  child: widgetLeft!,
                  onTap: onClickWidgetLeft,
                )
              : const SizedBox(),
          widgetCenter != null
              ? GestureDetector(
                  child: widgetCenter!,
                  onTap: onClickWidgetCenter,
                )
              : const SizedBox(),
          widgetRight != null
              ? GestureDetector(
                  child: widgetRight!,
                  onTap: onCLickWidgetRight,
                )
              : const SizedBox()
        ],
      ),
    );
  }
}

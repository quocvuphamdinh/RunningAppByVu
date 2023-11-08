import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';

class AppBarTwoSide extends StatelessWidget {
  const AppBarTwoSide(
      {super.key,
      this.widgetLeft,
      this.onClickWidgetLeft,
      this.onCLickWidgetRight,
      this.widgetRight});

  final Widget? widgetLeft;
  final Widget? widgetRight;
  final Function()? onClickWidgetLeft;
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

import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';

class ResultRunDataRow extends StatelessWidget {
  const ResultRunDataRow(
      {super.key,
      required this.icon,
      required this.titleText,
      this.valueText = "",
      this.valueTextColor,
      this.isValueTextWidget = false,
      this.valueTextWidget = const SizedBox()});

  final ImageProvider icon;
  final String titleText;
  final String valueText;
  final Color? valueTextColor;
  final bool isValueTextWidget;
  final Widget valueTextWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppDimens.smallSpacingVer),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(image: icon, width: AppDimens.iconSmallSize),
          SizedBox(
            width: AppDimens.size10,
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(titleText,
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.w500)),
              !isValueTextWidget
                  ? Text(valueText,
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: valueTextColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: "SecularOne"))
                  : valueTextWidget
            ],
          ))
        ],
      ),
    );
  }
}

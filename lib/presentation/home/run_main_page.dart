import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/presentation/home/run_main_controller.dart';
import 'package:running_app_flutter/widgets/appbar/app_bar_two_side.dart';

class RunMainPage extends GetView<RunMainController> {
  const RunMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      body: SafeArea(
          child: Column(
        children: [
          AppBarTwoSide(
            widgetLeft: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Running app",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryColor,
                      fontSize: 20.sp,
                      fontFamily: "OsWald"),
                ),
                RichText(
                  text: TextSpan(
                      text: "Let's go ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryColor,
                          fontSize: AppDimens.mediumTextSize,
                          fontStyle: FontStyle.italic),
                      children: [
                        TextSpan(
                            text: "Phạm Đình Quốc Vũ",
                            style: TextStyle(
                                color: AppColor.textPrimaryColor,
                                fontSize: AppDimens.mediumTextSize,
                                fontStyle: FontStyle.italic))
                      ]),
                )
              ],
            ),
            onCLickWidgetRight: () {},
            widgetRight: Icon(
              Icons.info_outline,
              size: AppDimens.iconMediumSize,
              color: AppColor.primaryColor,
            ),
          )
        ],
      )),
    );
  }
}

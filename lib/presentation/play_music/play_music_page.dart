import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/components/components.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/widgets/appbar/app_bar_three_side.dart';
import 'package:running_app_flutter/widgets/core/text_title.dart';

class PlayMusicPage extends StatefulWidget {
  const PlayMusicPage({super.key, required this.duration});

  final int duration;

  @override
  State<PlayMusicPage> createState() => _PlayMusicPageState();
}

class _PlayMusicPageState extends State<PlayMusicPage> {
  var _lowerValue = 0;
  var _upperValue = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primaryColor,
      height: Get.height * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const AppBarThreeSide(
            backgroundColor: AppColor.primaryColor,
            widgetCenter: TextTitle(
                text: "Vũ Running App Music", textColor: AppColor.whiteColor),
          ),
          Expanded(
              child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: ((context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: AppDimens.smallSpacingVer),
                    height: 100.h,
                    color: AppColor.grey,
                  );
                })),
          )),
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppDimens.smallSpacingVer),
            child: Text(
              "Music name",
              style: TextStyle(color: AppColor.whiteColor, fontSize: 16.sp),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppDimens.smallSpacingHor),
            child: FlutterSlider(
              tooltip: FlutterSliderTooltip(
                  alwaysShowTooltip: false, disabled: true),
              trackBar: const FlutterSliderTrackBar(
                  activeTrackBar: BoxDecoration(color: AppColor.whiteColor),
                  inactiveTrackBar: BoxDecoration(color: AppColor.grey)),
              handlerWidth: 0,
              touchSize: 5,
              values: [_lowerValue.toDouble()],
              max: widget.duration.toDouble(),
              min: 0,
              onDragging: (handlerIndex, lowerValue, upperValue) {
                _lowerValue = (lowerValue as double).round();
                _upperValue = (upperValue as double).round();

                setState(() {});
              },
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
                  left: AppDimens.smallSpacingHor,
                  right: AppDimens.smallSpacingHor,
                  bottom: AppDimens.smallSpacingVer),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      Components.getFormattedTimer(
                          ms: _lowerValue,
                          includeMinute: true,
                          includeSecond: true),
                      style: TextStyle(
                          fontSize: 14.sp, color: AppColor.whiteColor)),
                  Text(
                      Components.getFormattedTimer(
                          ms: widget.duration,
                          includeMinute: true,
                          includeSecond: true),
                      style: TextStyle(
                          fontSize: 14.sp, color: AppColor.whiteColor))
                ],
              )),
          Padding(
            padding: EdgeInsets.only(bottom: AppDimens.smallSpacingVer),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.skip_previous,
                    size: AppDimens.iconLargeSize, color: AppColor.whiteColor),
                Icon(Icons.play_arrow,
                    size: AppDimens.iconLargeSize, color: AppColor.whiteColor),
                Icon(Icons.skip_next,
                    size: AppDimens.iconLargeSize, color: AppColor.whiteColor)
              ],
            ),
          )
        ],
      ),
    );
  }
}

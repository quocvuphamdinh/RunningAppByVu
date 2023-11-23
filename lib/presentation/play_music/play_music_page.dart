import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/components/components.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/presentation/play_music/play_music_controller.dart';
import 'package:running_app_flutter/presentation/play_music/widgets/music_item.dart';
import 'package:running_app_flutter/widgets/appbar/app_bar_three_side.dart';
import 'package:running_app_flutter/widgets/core/text_title.dart';

class PlayMusicPage extends GetView<PlayMusicController> {
  const PlayMusicPage({super.key});

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
              child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppDimens.mediumSpacingHor),
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: Obx(() => ListView.builder(
                  itemCount: controller.listMusic.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                        onTap: () {
                          controller.onClickPlayAtIndex(index);
                        },
                        child: MusicItem(music: controller.listMusic[index]));
                  }))),
            ),
          )),
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppDimens.smallSpacingVer),
            child: Obx(() => Text(
                  controller.musicCurrent.value.name,
                  style: TextStyle(color: AppColor.whiteColor, fontSize: 16.sp),
                )),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppDimens.smallSpacingHor),
            child: Obx(() => FlutterSlider(
                  tooltip: FlutterSliderTooltip(
                      alwaysShowTooltip: false, disabled: true),
                  trackBar: const FlutterSliderTrackBar(
                      activeTrackBar: BoxDecoration(color: AppColor.whiteColor),
                      inactiveTrackBar: BoxDecoration(color: AppColor.grey)),
                  handlerWidth: 0,
                  touchSize: 5,
                  values: [controller.progressValue.toDouble()],
                  max: controller.duration.toDouble(),
                  min: 0,
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    controller
                        .onProgressChanged((lowerValue as double).round());
                  },
                )),
          ),
          Padding(
              padding: EdgeInsets.only(
                  left: AppDimens.smallSpacingHor,
                  right: AppDimens.smallSpacingHor,
                  bottom: AppDimens.smallSpacingVer),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Text(
                      Components.getFormattedTimer(
                          ms: controller.progressValue.value,
                          includeMinute: true,
                          includeSecond: true),
                      style: TextStyle(
                          fontSize: 14.sp, color: AppColor.whiteColor))),
                  Obx(() => Text(
                      Components.getFormattedTimer(
                          ms: controller.duration.value,
                          includeMinute: true,
                          includeSecond: true),
                      style: TextStyle(
                          fontSize: 14.sp, color: AppColor.whiteColor)))
                ],
              )),
          Padding(
            padding: EdgeInsets.only(bottom: AppDimens.smallSpacingVer),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    controller.onClickPre();
                  },
                  icon: Icon(Icons.skip_previous,
                      size: AppDimens.iconLargeSize,
                      color: AppColor.whiteColor),
                ),
                IconButton(
                  onPressed: () {
                    controller.onClickPlay();
                  },
                  icon: Obx(() => Icon(
                      controller.isPlaying.value
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: AppDimens.iconLargeSize,
                      color: AppColor.whiteColor)),
                ),
                IconButton(
                  onPressed: () {
                    controller.onClickNext();
                  },
                  icon: Icon(Icons.skip_next,
                      size: AppDimens.iconLargeSize,
                      color: AppColor.whiteColor),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

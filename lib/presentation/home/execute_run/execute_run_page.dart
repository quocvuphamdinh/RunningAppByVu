import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:running_app_flutter/components/components.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/presentation/home/execute_run/execute_run_controller.dart';
import 'package:running_app_flutter/presentation/play_music/play_music_page.dart';
import 'package:running_app_flutter/widgets/appbar/app_bar_three_side.dart';
import 'package:running_app_flutter/widgets/core/run_button_circle.dart';
import 'package:running_app_flutter/widgets/core/text_title.dart';

class ExecuteRunPage extends GetView<ExecuteRunController> {
  const ExecuteRunPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppBarThreeSide(
            widgetLeft: Obx(() => controller.isToggleRun.value
                ? const Icon(Icons.stop, color: AppColor.redColor)
                : const SizedBox()),
            onClickWidgetLeft: () async {
              if (controller.isToggleRun.value) {
                await controller.saveRun();
              }
            },
            widgetCenter: Row(
              children: [
                Components.SVGIcon(
                    path: 'assets/svg/ic_play_music.svg',
                    color: AppColor.grey,
                    size: AppDimens.iconLightMediumSize),
                SizedBox(
                  width: AppDimens.aBitSpacingHor,
                ),
                const TextTitle(text: "Play music", textColor: AppColor.grey)
              ],
            ),
            onClickWidgetCenter: () {
              showCupertinoModalPopup(
                  builder: (context) => Dismissible(
                      onDismissed: (_) => Navigator.of(context).pop(),
                      direction: DismissDirection.down,
                      key: const Key("1"),
                      child: const PlayMusicPage()),
                  context: context);
            },
            widgetRight: Icon(Icons.close,
                size: AppDimens.iconSmallSize, color: AppColor.grey),
            onCLickWidgetRight: () {
              if (controller.isToggleRun.value) {
                controller.showExitRunningDialog(
                    onPressOK: controller.onBack());
              } else {
                controller.onBack();
              }
            },
          ),
          Text(
            "RUNNING",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.primaryColor,
                fontSize: AppDimens.headerTitleSize),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppDimens.smallSpacingVer),
            child: Obx(() => Text(
                  Components.getFormattedTimer(
                      ms: controller.runDuration.value.inMilliseconds,
                      includeHour: true,
                      includeMinute: true,
                      includeSecond: true,
                      includeMillis: true),
                  style: TextStyle(
                      fontSize: AppDimens.headerTitleSize,
                      color: AppColor.grey),
                )),
          ),
          RunButtonCircle(
              gradients: const [AppColor.startColor, AppColor.endColor],
              child: Obx(() => Text(
                  controller.isRunning.value
                      ? "Pause"
                      : (controller.isToggleRun.value ? "Resume" : "Start"),
                  style:
                      TextStyle(fontSize: 16.sp, color: AppColor.whiteColor))),
              onClick: (() {
                controller.getCurrentLocation(context);
              })),
          Expanded(
            child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: AppDimens.smallSpacingHor,
                    vertical: AppDimens.smallSpacingVer),
                height: Get.height * 0.5,
                decoration: BoxDecoration(boxShadow: const [
                  BoxShadow(
                    blurStyle: BlurStyle.solid,
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0),
                    blurRadius: 5.0,
                  ),
                ], borderRadius: BorderRadius.all(Radius.circular(5.r))),
                child: Obx(() => GoogleMap(
                      polylines: controller.polyline,
                      markers: Set.of((controller.marker.value != null)
                          ? [controller.marker.value!]
                          : []),
                      initialCameraPosition: const CameraPosition(
                          target: LatLng(10.762622, 106.660172), zoom: 15.0),
                      onMapCreated: (GoogleMapController gooleMapcontroller) {
                        controller.mapController.complete(gooleMapcontroller);
                      },
                    ))),
          )
        ],
      )),
    );
  }
}

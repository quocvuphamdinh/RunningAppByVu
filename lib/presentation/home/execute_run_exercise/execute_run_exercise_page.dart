import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:running_app_flutter/components/components.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/config/res/app_image.dart';
import 'package:running_app_flutter/presentation/home/execute_run_exercise/execute_run_exercise_controller.dart';
import 'package:running_app_flutter/presentation/play_music/play_music_page.dart';
import 'package:running_app_flutter/widgets/core/run_button_circle.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ExecuteRunExercisePage extends GetView<ExecuteRunExerciseController> {
  const ExecuteRunExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onBackPress,
      child: Scaffold(
        body: SafeArea(
            child: Container(
          width: Get.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Color(0xff181818), Color(0xff111111)])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => StepProgressIndicator(
                    totalSteps:
                        (controller.totalWorkoutsDuration / 100).round(),
                    currentStep:
                        (controller.runDuration.value.inMilliseconds / 100)
                            .round(),
                    size: 20.h,
                    padding: 0,
                    unselectedColor: AppColor.grey300,
                    selectedGradientColor: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColor.startColor, AppColor.endColor],
                    ),
                  )),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: AppDimens.smallSpacingVer),
                child: Obx(() => Text(
                    "Time left - ${Components.getFormattedTimer(ms: controller.timeLeft.value, includeMinute: true, includeSecond: true)}",
                    style: TextStyle(
                        color: AppColor.whiteColor, fontSize: 16.sp))),
              ),
              Container(
                margin:
                    EdgeInsets.symmetric(horizontal: AppDimens.smallSpacingHor),
                padding:
                    EdgeInsets.symmetric(vertical: AppDimens.mediumSpacingVer),
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    border: Border.all(width: 2.w, color: AppColor.whiteColor)),
                child: Column(
                  children: [
                    Obx(() => Text(
                          controller
                              .workouts[controller.currentWorkoutIndex.value]
                              .name
                              .toUpperCase(),
                          style: TextStyle(
                              color: AppColor.whiteColor, fontSize: 20.sp),
                        )),
                    SizedBox(
                      height: AppDimens.size10,
                    ),
                    Obx(() => Text(
                          Components.getFormattedTimer(
                              ms: controller.runDuration.value.inMilliseconds,
                              includeMinute: true,
                              includeSecond: true),
                          style: TextStyle(
                              color: AppColor.whiteColor,
                              fontSize: 40.sp,
                              fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      height: AppDimens.size10,
                    ),
                    Obx(() => Text(
                          "${controller.currentWorkoutIndex.value + 1}/${controller.workouts.length}",
                          style: TextStyle(
                              color: AppColor.whiteColor, fontSize: 20.sp),
                        ))
                  ],
                ),
              ),
              Container(
                margin:
                    EdgeInsets.symmetric(vertical: AppDimens.smallSpacingVer),
                height: Get.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Image(image: AppImages.icDistance),
                        Obx(() => Text(
                              "${controller.distance.value / 1000}",
                              style: TextStyle(
                                  color: AppColor.whiteColor,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                          child: Text(
                            "km",
                            style: TextStyle(
                                color: AppColor.whiteColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: AppColor.whiteColor,
                      height: Get.height * 0.2,
                      width: 1.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Image(image: AppImages.icAvgSpeed),
                        Obx(() => Text(
                              "${controller.avgSpeed.value}",
                              style: TextStyle(
                                  color: AppColor.whiteColor,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                          child: Text(
                            "km/h",
                            style: TextStyle(
                                color: AppColor.whiteColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: AppColor.whiteColor,
                      height: Get.height * 0.2,
                      width: 1.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Image(image: AppImages.icCalories),
                        Obx(() => Text(
                              "${controller.caloriesBurned.value}",
                              style: TextStyle(
                                  color: AppColor.whiteColor,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                          child: Text(
                            "kcal",
                            style: TextStyle(
                                color: AppColor.whiteColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Obx(() => !controller.isToggleRun.value
                  ? RunButtonCircle(
                      backgroundColor: AppColor.grey300,
                      child: Icon(Icons.play_arrow,
                          size: AppDimens.iconMediumSize,
                          color: AppColor.whiteColor),
                      onClick: () {
                        controller.getCurrentLocation(context);
                      })
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RunButtonCircle(
                            backgroundColor: AppColor.grey300,
                            child: Icon(Icons.stop,
                                size: AppDimens.iconMediumSize,
                                color: AppColor.whiteColor),
                            onClick: () async {
                              await controller.saveRun();
                              controller.onBack();
                            }),
                        SizedBox(
                          width: AppDimens.size30,
                        ),
                        RunButtonCircle(
                            backgroundColor: AppColor.grey300,
                            child: Icon(
                                controller.isRunning.value
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                size: AppDimens.iconMediumSize,
                                color: AppColor.whiteColor),
                            onClick: () {
                              controller.getCurrentLocation(context);
                            }),
                      ],
                    )),
              SizedBox(
                height: AppDimens.size10,
              ),
              Expanded(
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
              GestureDetector(
                onTap: () {
                  showCupertinoModalPopup(
                      builder: (context) => Dismissible(
                          onDismissed: (_) => Navigator.of(context).pop(),
                          direction: DismissDirection.down,
                          key: const Key("1"),
                          child: const PlayMusicPage()),
                      context: context);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: AppDimens.aBitSpacingVer),
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Components.SVGIcon(
                            path: 'assets/svg/ic_play_music.svg',
                            color: AppColor.whiteColor,
                            size: AppDimens.iconLightMediumSize),
                        SizedBox(
                          width: AppDimens.aBitSpacingHor,
                        ),
                        Text("Play music",
                            style: TextStyle(
                                color: AppColor.whiteColor, fontSize: 25.sp))
                      ],
                    )),
              )
            ],
          ),
        )),
      ),
    );
  }
}

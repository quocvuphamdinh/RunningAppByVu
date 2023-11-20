import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:running_app_flutter/components/components.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/config/res/app_image.dart';
import 'package:running_app_flutter/presentation/home/execute_run_exercise/execute_run_exercise_controller.dart';
import 'package:running_app_flutter/widgets/core/run_button_circle.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ExecuteRunExercisePage extends GetView<ExecuteRunExerciseController> {
  const ExecuteRunExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            StepProgressIndicator(
              totalSteps: 100,
              currentStep: 50,
              size: 20.h,
              padding: 0,
              unselectedColor: AppColor.grey300,
              selectedGradientColor: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColor.startColor, AppColor.endColor],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: AppDimens.smallSpacingVer),
              child: Text("Time left - 18:00",
                  style:
                      TextStyle(color: AppColor.whiteColor, fontSize: 16.sp)),
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
                  Text(
                    "WALK",
                    style:
                        TextStyle(color: AppColor.whiteColor, fontSize: 20.sp),
                  ),
                  SizedBox(
                    height: AppDimens.size10,
                  ),
                  Text(
                    "00:00",
                    style: TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 40.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: AppDimens.size10,
                  ),
                  Text(
                    "1/3",
                    style:
                        TextStyle(color: AppColor.whiteColor, fontSize: 20.sp),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: AppDimens.smallSpacingVer),
              height: Get.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Image(image: AppImages.icDistance),
                      Text(
                        "0.000",
                        style: TextStyle(
                            color: AppColor.whiteColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "km",
                        style: TextStyle(
                            color: AppColor.whiteColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
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
                      Text(
                        "0.0",
                        style: TextStyle(
                            color: AppColor.whiteColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "km/h",
                        style: TextStyle(
                            color: AppColor.whiteColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
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
                      Text(
                        "0",
                        style: TextStyle(
                            color: AppColor.whiteColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "kcal",
                        style: TextStyle(
                            color: AppColor.whiteColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
            RunButtonCircle(
                backgroundColor: AppColor.grey300,
                child: Icon(Icons.play_arrow,
                    size: AppDimens.iconMediumSize, color: AppColor.whiteColor),
                onClick: () {}),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     RunButtonCircle(
            //         backgroundColor: AppColor.grey300,
            //         child: Icon(Icons.stop,
            //             size: AppDimens.iconMediumSize,
            //             color: AppColor.whiteColor),
            //         onClick: () {}),
            //     SizedBox(
            //       width: AppDimens.size30,
            //     ),
            //     RunButtonCircle(
            //         backgroundColor: AppColor.grey300,
            //         child: Icon(Icons.pause,
            //             size: AppDimens.iconMediumSize,
            //             color: AppColor.whiteColor),
            //         onClick: () {}),
            //   ],
            // ),
            SizedBox(
              height: AppDimens.size10,
            ),
            Expanded(
                child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(10.762622, 106.660172), zoom: 50.0),
              onMapCreated: (GoogleMapController gooleMapcontroller) {
                controller.mapController.complete(gooleMapcontroller);
              },
            )),
            GestureDetector(
              onTap: () {},
              child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: AppDimens.smallSpacingVer),
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
    );
  }
}

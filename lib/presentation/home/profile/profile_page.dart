import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:running_app_flutter/components/components.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/config/res/app_image.dart';
import 'package:running_app_flutter/presentation/home/profile/profile_controller.dart';
import 'package:running_app_flutter/routes/app_routes.dart';
import 'package:running_app_flutter/widgets/appbar/app_bar_two_side.dart';
import 'package:running_app_flutter/widgets/core/run_button.dart';
import 'package:running_app_flutter/widgets/core/text_title.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  Future<void> _pickImageFromGallery() async {
    final imagePicker = ImagePicker();
    final XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      controller.uploadAvatar(imageFile);
    }
  }

  Future<void> _pickImageFromCamera() async {
    final imagePicker = ImagePicker();
    final XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      controller.uploadAvatar(imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppBarTwoSide(
                widgetLeft: const TextTitle(text: "Profile"),
                widgetRight: Icon(
                  Icons.settings,
                  color: AppColor.primaryColor,
                  size: AppDimens.iconSmallSize,
                ),
                onCLickWidgetRight: () {
                  controller.goToEditProfile();
                },
              ),
              controller.user.value != null
                  ? (Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppDimens.mediumSpacingVer),
                        child: SmartRefresher(
                            onRefresh: controller.onRefresh,
                            controller: controller.refreshController,
                            header: const WaterDropHeader(
                              refresh: CupertinoActivityIndicator(),
                              complete: Icon(Icons.check, color: AppColor.grey),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: AppDimens.smallSpacingVer),
                                    child: GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(10.0.r),
                                                  topRight:
                                                      Radius.circular(10.0.r)),
                                            ),
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: AppDimens
                                                        .mediumSpacingHor),
                                                decoration: BoxDecoration(
                                                    color: AppColor
                                                        .appBackgroundColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r)),
                                                height: 150.h,
                                                width: Get.width,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Get.back();
                                                        if ((controller
                                                                    .user
                                                                    .value!
                                                                    .avartar !=
                                                                null ||
                                                            controller
                                                                .user
                                                                .value!
                                                                .avartar!
                                                                .isNotEmpty)) {
                                                          Get.toNamed(
                                                              AppRoutes
                                                                  .ShowImage,
                                                              arguments: {
                                                                "image_url":
                                                                    controller
                                                                        .user
                                                                        .value!
                                                                        .avartar
                                                              });
                                                        }
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text("Show image",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16.sp)),
                                                          const Icon(Icons
                                                              .remove_red_eye)
                                                        ],
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Get.back();
                                                        _pickImageFromGallery();
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text("Upload a photo",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16.sp)),
                                                          const Icon(
                                                              Icons.image)
                                                        ],
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Get.back();
                                                        _pickImageFromCamera();
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text("Take a photo",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16.sp)),
                                                          const Icon(
                                                              Icons.camera_alt)
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      child: Obx(() => (controller
                                                      .user.value!.avartar ==
                                                  null ||
                                              controller
                                                  .user.value!.avartar!.isEmpty)
                                          ? CircleAvatar(
                                              backgroundImage:
                                                  AppImages.defaultAvatar,
                                              radius: 50.r,
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: controller
                                                  .user.value!.avartar!,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                      child:
                                                          CupertinoActivityIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      CircleAvatar(
                                                backgroundImage:
                                                    AppImages.defaultAvatar,
                                                radius: 50.r,
                                              ),
                                              imageBuilder:
                                                  ((context, imageProvider) =>
                                                      CircleAvatar(
                                                        backgroundImage:
                                                            imageProvider,
                                                        radius: 50.r,
                                                      )),
                                            )),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: AppDimens.smallSpacingVer),
                                    child: Obx(() => Text(
                                          controller.user.value!.fullName,
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.primaryColor),
                                        )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: AppDimens.smallSpacingVer),
                                    child: RunButton(
                                        buttonText: "Sync Data",
                                        onClick: () {
                                          controller.syncData();
                                        },
                                        backgroundColor: AppColor.endColor,
                                        minWidth: Get.width * 0.2),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: AppDimens.smallSpacingHor,
                                        right: AppDimens.smallSpacingHor,
                                        bottom: AppDimens.smallSpacingHor),
                                    padding: EdgeInsets.symmetric(
                                        vertical: AppDimens.smallSpacingVer,
                                        horizontal: AppDimens.smallSpacingHor),
                                    decoration: BoxDecoration(
                                        color: AppColor.grey90,
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom:
                                                  AppDimens.smallSpacingVer),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Gender",
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    color:
                                                        AppColor.primaryColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Obx(() => Text(
                                                  controller.user.value!.gender,
                                                  style: TextStyle(
                                                      fontSize: 16.sp))),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom:
                                                  AppDimens.smallSpacingVer),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Distance goal",
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    color:
                                                        AppColor.primaryColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Obx(() => Text(
                                                  "${controller.user.value!.distanceGoal} km",
                                                  style: TextStyle(
                                                      fontSize: 16.sp))),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom:
                                                  AppDimens.smallSpacingVer),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Height",
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    color:
                                                        AppColor.primaryColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Obx(() => Text(
                                                  "${controller.user.value!.height} cm",
                                                  style: TextStyle(
                                                      fontSize: 16.sp))),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Weight",
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: AppColor.primaryColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Obx(() => Text(
                                                "${controller.user.value!.weight} kg",
                                                style: TextStyle(
                                                    fontSize: 16.sp))),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: AppDimens.smallSpacingHor,
                                        right: AppDimens.smallSpacingHor,
                                        bottom: 40.h),
                                    padding: EdgeInsets.symmetric(
                                        vertical: AppDimens.smallSpacingVer,
                                        horizontal: AppDimens.smallSpacingHor),
                                    decoration: BoxDecoration(
                                        color: AppColor.grey90,
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("My progress",
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                color: AppColor.primaryColor,
                                                fontWeight: FontWeight.bold)),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: AppDimens.aBitSpacingVer),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Obx(() => Text(
                                                    (controller.totalDistance
                                                                .value /
                                                            1000)
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: AppDimens
                                                            .biggestTextSize,
                                                        color: AppColor.yellow,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  )),
                                              Text(
                                                "TOTAL KM",
                                                style: TextStyle(
                                                    fontSize: AppDimens
                                                        .mediumTextSize),
                                              )
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Obx(() => Text(
                                                      Components
                                                          .convertDateTimeMilliesToString(
                                                              ms: controller
                                                                  .totalDuration
                                                                  .value,
                                                              dateFormat: "hh"),
                                                      style: TextStyle(
                                                          fontSize: AppDimens
                                                              .headerTitleSize,
                                                          color:
                                                              AppColor.yellow,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FontStyle.italic),
                                                    )),
                                                Text(
                                                  "TOTAL HOURS",
                                                  style: TextStyle(
                                                      fontSize: AppDimens
                                                          .mediumTextSize),
                                                )
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Obx(() => Text(
                                                      "${controller.totalCalories.value}",
                                                      style: TextStyle(
                                                          fontSize: AppDimens
                                                              .headerTitleSize,
                                                          color:
                                                              AppColor.yellow,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FontStyle.italic),
                                                    )),
                                                Text(
                                                  "TOTAL KCAL",
                                                  style: TextStyle(
                                                      fontSize: AppDimens
                                                          .mediumTextSize),
                                                )
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Obx(() => Text(
                                                      controller.avgSpeed.value
                                                          .toStringAsFixed(2),
                                                      style: TextStyle(
                                                          fontSize: AppDimens
                                                              .headerTitleSize,
                                                          color:
                                                              AppColor.yellow,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FontStyle.italic),
                                                    )),
                                                Text(
                                                  "AVG SPEED",
                                                  style: TextStyle(
                                                      fontSize: AppDimens
                                                          .mediumTextSize),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: AppDimens.smallSpacingHor,
                                          right: AppDimens.smallSpacingHor,
                                          bottom: AppDimens.smallSpacingHor),
                                      padding: EdgeInsets.symmetric(
                                          vertical: AppDimens.smallSpacingVer,
                                          horizontal:
                                              AppDimens.smallSpacingHor),
                                      decoration: BoxDecoration(
                                          color: AppColor.grey90,
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("See your run history",
                                              style: TextStyle(
                                                  fontSize:
                                                      AppDimens.largeTextSize,
                                                  color: AppColor.primaryColor,
                                                  fontWeight: FontWeight.bold)),
                                          Icon(Icons.history,
                                              color: AppColor.primaryColor,
                                              size: AppDimens.iconSmallSize)
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Get.toNamed(AppRoutes.RunHistory);
                                    },
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: AppDimens.smallSpacingHor,
                                          right: AppDimens.smallSpacingHor,
                                          bottom: AppDimens.smallSpacingHor),
                                      padding: EdgeInsets.symmetric(
                                          vertical: AppDimens.smallSpacingVer,
                                          horizontal:
                                              AppDimens.smallSpacingHor),
                                      decoration: BoxDecoration(
                                          color: AppColor.grey90,
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Change password",
                                              style: TextStyle(
                                                  fontSize:
                                                      AppDimens.largeTextSize,
                                                  color: AppColor.primaryColor,
                                                  fontWeight: FontWeight.bold)),
                                          Icon(Icons.key,
                                              color: AppColor.primaryColor,
                                              size: AppDimens.iconSmallSize)
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Get.toNamed(AppRoutes.ChangePassword);
                                    },
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: AppDimens.smallSpacingHor,
                                          right: AppDimens.smallSpacingHor,
                                          bottom: 50.h),
                                      padding: EdgeInsets.symmetric(
                                          vertical: AppDimens.smallSpacingVer,
                                          horizontal:
                                              AppDimens.smallSpacingHor),
                                      decoration: BoxDecoration(
                                          color: AppColor.grey90,
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Logout",
                                              style: TextStyle(
                                                  fontSize:
                                                      AppDimens.largeTextSize,
                                                  color: AppColor.redColor,
                                                  fontWeight: FontWeight.bold)),
                                          Icon(Icons.logout,
                                              color: AppColor.redColor,
                                              size: AppDimens.iconSmallSize)
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      controller.logout();
                                    },
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ))
                  : const Center(child: CupertinoActivityIndicator())
            ],
          )),
    );
  }
}

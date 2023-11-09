import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/config/res/app_image.dart';
import 'package:running_app_flutter/presentation/home/profile/profile_controller.dart';
import 'package:running_app_flutter/widgets/appbar/app_bar_two_side.dart';
import 'package:running_app_flutter/widgets/core/run_button.dart';
import 'package:running_app_flutter/widgets/core/text_title.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

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
                onCLickWidgetRight: () {},
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: AppDimens.mediumSpacingVer),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: AppDimens.smallSpacingVer),
                      child: CircleAvatar(
                        backgroundImage: AppImages.activityBackground,
                        radius: 60.r,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: AppDimens.smallSpacingVer),
                      child: Text(
                        "Phạm Đình Quốc Vũ",
                        style: TextStyle(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: AppDimens.smallSpacingVer),
                      child: RunButton(
                          buttonText: "Sync Data",
                          onClick: () {},
                          backgroundColor: AppColor.endColor,
                          minWidth: Get.width * 0.2),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

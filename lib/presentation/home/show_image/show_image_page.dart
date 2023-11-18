import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_image.dart';
import 'package:running_app_flutter/presentation/home/show_image/show_image_controller.dart';
import 'package:running_app_flutter/widgets/appbar/app_bar_two_side.dart';

class ShowImagePage extends GetView<ShowImageController> {
  const ShowImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InteractiveViewer(
                  panEnabled: true, // Set it to false
                  minScale: 0.5,
                  maxScale: 2,
                  child: Image(image: AppImages.activityBackground),
                ),
              )
            ],
          ),
          AppBarTwoSide(
            backgroundColor: Colors.transparent,
            widgetLeft: const Icon(Icons.arrow_back_ios, color: AppColor.grey),
            onClickWidgetLeft: () {
              Get.back();
            },
          ),
        ],
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/presentation/home/analysis/analysis_controller.dart';

class AnalysisDayPage extends GetView<AnalysisController> {
  const AnalysisDayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.grey80,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: AppDimens.mediumSpacingVer),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: AppDimens.smallSpacingVer),
                color: AppColor.appBackgroundColor,
                height: Get.height * 0.6,
              ),
              Container(
                margin: EdgeInsets.only(top: AppDimens.smallSpacingVer),
                color: AppColor.appBackgroundColor,
                height: Get.height * 0.6,
              ),
              Container(
                margin: EdgeInsets.only(top: AppDimens.smallSpacingVer),
                color: AppColor.appBackgroundColor,
                height: Get.height * 0.6,
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/presentation/home/analysis/analysis_controller.dart';

class AnalysisPage extends GetView<AnalysisController> {
  const AnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      body: SafeArea(
          child: Center(
        child: Text("Analysis Page"),
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/presentation/home/analysis/analysis_controller.dart';

class AnalysisMonthPage extends GetView<AnalysisController> {
  const AnalysisMonthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.grey80,
      child: Center(
        child: Text("Month"),
      ),
    );
  }
}

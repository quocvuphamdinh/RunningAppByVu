import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/presentation/home/analysis/analysis_controller.dart';
import 'package:running_app_flutter/presentation/home/analysis/pages/analysis_day_page.dart';
import 'package:running_app_flutter/presentation/home/analysis/pages/analysis_month_page.dart';
import 'package:running_app_flutter/widgets/appbar/app_bar_with_bottom_tab.dart';
import 'package:running_app_flutter/widgets/core/text_title.dart';

class AnalysisPage extends GetView<AnalysisController> {
  const AnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey80,
      body: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.only(bottom: AppDimens.mediumSpacingVer),
            child: AppBarWithBottomTab(
              widgetAppBarLeft: const TextTitle(text: "Analysis"),
              contentWidgetTabBars: [
                Text(
                  "DAY",
                  style: TextStyle(fontSize: AppDimens.mediumTextSize),
                ),
                Text(
                  "MONTH",
                  style: TextStyle(fontSize: AppDimens.mediumTextSize),
                )
              ],
              widgetBodies: const [AnalysisDayPage(), AnalysisMonthPage()],
            ),
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/constant/data_run_types.dart';
import 'package:running_app_flutter/presentation/home/analysis/analysis_controller.dart';
import 'package:running_app_flutter/presentation/home/analysis/widgets/analysis_card.dart';

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
              AnalysisCard(
                  topTitle: "Distance (meter)",
                  datas: controller.analysisDayBars,
                  type: DataRunTypes.DISTANCE,
                  analysisTypes: DataAnalysisTypes.DAY,
                  onSelectedDate: (selectedDate) {
                    print(selectedDate);
                  }),
              AnalysisCard(
                  topTitle: "Duration (minute)",
                  datas: controller.analysisDayBars,
                  type: DataRunTypes.DURATION,
                  analysisTypes: DataAnalysisTypes.DAY,
                  onSelectedDate: (selectedDate) {}),
              AnalysisCard(
                  topTitle: "Calories Burned (kcal)",
                  datas: controller.analysisDayBars,
                  type: DataRunTypes.CALORIESBURNED,
                  analysisTypes: DataAnalysisTypes.DAY,
                  onSelectedDate: (selectedDate) {}),
              AnalysisCard(
                  topTitle: "Average Speed (km/h)",
                  datas: controller.analysisDayBars,
                  type: DataRunTypes.AVGSPEED,
                  analysisTypes: DataAnalysisTypes.DAY,
                  onSelectedDate: (selectedDate) {})
            ],
          ),
        ),
      ),
    );
  }
}

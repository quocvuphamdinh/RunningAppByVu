import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/constant/data_run_types.dart';
import 'package:running_app_flutter/presentation/home/analysis/analysis_controller.dart';
import 'package:running_app_flutter/presentation/home/analysis/widgets/analysis_card.dart';

class AnalysisMonthPage extends GetView<AnalysisController> {
  const AnalysisMonthPage({super.key});

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
                  type: DataRunTypes.DISTANCE,
                  analysisTypes: DataAnalysisTypes.MONTH,
                  onSelectedDate: (selectedDate) {
                    controller.onSelectedDistance(
                        selectedDate.millisecondsSinceEpoch,
                        DataAnalysisTypes.MONTH);
                  }),
              AnalysisCard(
                  topTitle: "Duration (minute)",
                  type: DataRunTypes.DURATION,
                  analysisTypes: DataAnalysisTypes.MONTH,
                  onSelectedDate: (selectedDate) {
                    controller.onSelectedDuration(
                        selectedDate.millisecondsSinceEpoch,
                        DataAnalysisTypes.MONTH);
                  }),
              AnalysisCard(
                  topTitle: "Calories Burned (kcal)",
                  type: DataRunTypes.CALORIESBURNED,
                  analysisTypes: DataAnalysisTypes.MONTH,
                  onSelectedDate: (selectedDate) {
                    controller.onSelectedCalories(
                        selectedDate.millisecondsSinceEpoch,
                        DataAnalysisTypes.MONTH);
                  }),
              AnalysisCard(
                  topTitle: "Average Speed (km/h)",
                  type: DataRunTypes.AVGSPEED,
                  analysisTypes: DataAnalysisTypes.MONTH,
                  onSelectedDate: (selectedDate) {
                    controller.onSelectedAvgSpeed(
                        selectedDate.millisecondsSinceEpoch,
                        DataAnalysisTypes.MONTH);
                  })
            ],
          ),
        ),
      ),
    );
  }
}

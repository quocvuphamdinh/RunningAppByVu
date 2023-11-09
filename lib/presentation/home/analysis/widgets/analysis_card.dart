import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/components/components.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/config/res/app_image.dart';
import 'package:running_app_flutter/constant/data_run_types.dart';
import 'package:running_app_flutter/presentation/home/analysis/models/analysis_bar_model.dart';
import 'package:running_app_flutter/presentation/home/analysis/widgets/bar_titles.dart';

class AnalysisCard extends StatefulWidget {
  const AnalysisCard(
      {super.key,
      required this.topTitle,
      required this.type,
      required this.analysisTypes,
      required this.datas,
      required this.onSelectedDate});

  final String topTitle;
  final DataRunTypes type;
  final DataAnalysisTypes analysisTypes;
  final List<AnalysisBarModel> datas;
  final Function(DateTime selectedDate) onSelectedDate;

  @override
  State<AnalysisCard> createState() => _AnalysisCardState();
}

class _AnalysisCardState extends State<AnalysisCard> {
  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    widget.onSelectedDate(dateTime);
  }

  List<Color> getListColorByType(DataRunTypes dataType) {
    if (dataType == DataRunTypes.DISTANCE) {
      return [AppColor.startColor, AppColor.endColor];
    } else if (dataType == DataRunTypes.DURATION) {
      return [AppColor.startColor2, AppColor.endColor2];
    } else if (dataType == DataRunTypes.CALORIESBURNED) {
      return [AppColor.startColor3, AppColor.endColor3];
    } else {
      return [AppColor.avgSpeedColor, AppColor.teal200];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: AppDimens.aBitSpacingVer,
          horizontal: AppDimens.aBitSpacingHor),
      margin: EdgeInsets.only(top: AppDimens.smallSpacingVer),
      color: AppColor.appBackgroundColor,
      height: Get.height * 0.6,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.topTitle,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                    fontSize: AppDimens.largeTextSize),
              ),
              GestureDetector(
                child: Image(
                  image: AppImages.icCalendar,
                  width: AppDimens.iconSmallSize,
                ),
                onTap: () {
                  showCupertinoModalPopup(
                      context: context,
                      builder: (context) => SizedBox(
                            width: Get.width,
                            height: 250.h,
                            child: CupertinoDatePicker(
                                maximumDate:
                                    DateTime.now().add(const Duration(days: 1)),
                                minimumDate: DateTime(1990, 1, 1),
                                mode: widget.analysisTypes ==
                                        DataAnalysisTypes.DAY
                                    ? CupertinoDatePickerMode.date
                                    : CupertinoDatePickerMode.monthYear,
                                initialDateTime: dateTime,
                                backgroundColor: AppColor.appBackgroundColor,
                                onDateTimeChanged: ((value) {
                                  setState(() {
                                    dateTime = value;
                                    widget.onSelectedDate(dateTime);
                                  });
                                })),
                          ));
                },
              )
            ],
          ),
          Expanded(
            child: BarChart(
              BarChartData(
                  maxY: 100.0,
                  minY: 0,
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: BarTitles.getTopBottomTitles(widget.datas),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: BarTitles.getTopBottomTitles(widget.datas),
                    ),
                  ),
                  barGroups: widget.datas
                      .map((e) => BarChartGroupData(x: e.id, barRods: [
                            BarChartRodData(
                                toY: e.y,
                                width: widget.analysisTypes ==
                                        DataAnalysisTypes.DAY
                                    ? AppDimens.size20
                                    : AppDimens.size10,
                                gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: getListColorByType(widget.type)),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6.r),
                                    topRight: Radius.circular(6.r))),
                          ]))
                      .toList()),
              swapAnimationDuration:
                  const Duration(milliseconds: 150), // Optional
              swapAnimationCurve: Curves.linear, // Optional
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                widget.analysisTypes == DataAnalysisTypes.DAY
                    ? Components.convertDateTimeToString(dateTime: dateTime)
                    : Components.convertDateTimeToString(
                        dateTime: dateTime, dateFormat: 'MM-yyyy'),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                    fontSize: AppDimens.largeTextSize),
              )
            ],
          )
        ],
      ),
    );
  }
}

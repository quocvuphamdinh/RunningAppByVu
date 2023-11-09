import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:running_app_flutter/presentation/home/analysis/models/analysis_bar_model.dart';

class BarTitles {
  static SideTitles getTopBottomTitles(List<AnalysisBarModel> list) =>
      SideTitles(
          showTitles: true,
          getTitlesWidget: ((value, meta) =>
              Text(list.firstWhere((element) => element.id == value).name)));
}

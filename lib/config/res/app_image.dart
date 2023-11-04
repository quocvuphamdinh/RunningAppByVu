import 'package:flutter/material.dart';

const String _imagePath = 'assets/images';
const String _iconPath = 'assets/icons';

class _Image extends AssetImage {
  const _Image(String fileName) : super('$_imagePath/$fileName');
}

class _Icon extends AssetImage {
  const _Icon(String fileName) : super('$_iconPath/$fileName');
}

class AppImages {
  // Image
  static const logoImage = _Image("runner.png");
  static const runnerWhiteImage = _Image("runner_white.png");
  static const activityBackground = _Image("activity_background.jpg");
  static const walkingBackground = _Image("walking_background.jpg");

  // Icon
  static const success = "assets/images/success.svg";
  static const icDoneSurvey = _Icon("ic_done_survey.png");
  static const icRun = _Icon("ic_run.png");
  static const icList = _Icon("ic_list.png");
  static const icAnalysis = _Icon("ic_analysis.png");
  static const icCaloriesBurn = _Icon("ic_calories_burn.png");
  static const icMilies = _Icon("ic_milies.png");
  static const icRunCount = _Icon("ic_run_count.png");
  static const icTired = _Icon("ic_tired.png");
  static const icRoad = _Icon("ic_road.png");
  static const icLongestDuration = _Icon("ic_longest_duration.png");
  static const icBestCaloriesBurned = _Icon("ic_best_calories_burned.png");
}

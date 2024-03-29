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
  static const recentExerciseBackground = _Image("background_recent.jpg");
  static const blackArrow = _Image("black_arrow.png");
  static const errorGif = _Image("error_gif.gif");
  static const defaultAvatar = _Image("default_avartar.jpg");

  // Icon
  static const success = "assets/images/success.svg";
  static const icDoneSurvey = _Icon("ic_done_survey.png");
  static const icRun = _Icon("ic_run.png");
  static const icList = _Icon("ic_list.png");
  static const icAnalysis = _Icon("ic_analysis.png");
  static const icCaloriesBurn = _Icon("ic_calories_burn.png");
  static const icMilies = _Icon("ic_milies.png");
  static const icRunCount = _Icon("ic_run_count.png");
  static const icSmiling = _Icon("ic_smiling.png");
  static const icNotSmiling = _Icon("ic_not_smiling.png");
  static const icTired = _Icon("ic_tired.png");
  static const icRoad = _Icon("ic_road.png");
  static const icLongestDuration = _Icon("ic_longest_duration.png");
  static const icBestCaloriesBurned = _Icon("ic_best_calories_burned.png");
  static const icCalendar = _Icon("ic_calendar.png");
  static const icCoolDown = _Icon("ic_cool_down.png");
  static const icAvgSpeedColor = _Icon("ic_avg_speed_color.png");
  static const icCaloriesColor = _Icon("ic_calories_color.png");
  static const icCompleteRunColor = _Icon("ic_complete_run.png");
  static const icDistanceColor = _Icon("ic_distance_color.png");
  static const icDurationColor = _Icon("ic_duration_color.png");
  static const icMovingTimeColor = _Icon("ic_moving_time_color.png");
  static const icCompleted = _Icon("ic_completed.png");
  static const icNotCompleted = _Icon("ic_not_completed.png");
  static const icDistance = _Icon("ic_distance.png");
  static const icAvgSpeed = _Icon("ic_average_speed.png");
  static const icCalories = _Icon("ic_calories.png");

  //gif
  static const icMusicGif = _Icon("ic_music_gif.gif");
}

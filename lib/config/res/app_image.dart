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

  // Icon
  static const success = "assets/images/success.svg";
  static const icDoneSurvey = _Icon("ic_done_survey.png");
}

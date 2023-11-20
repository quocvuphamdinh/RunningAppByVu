import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:running_app_flutter/config/res/app_color.dart';

class TextTitle extends StatelessWidget {
  const TextTitle({super.key, required this.text, this.textColor});

  final String text;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: textColor ?? AppColor.primaryColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          fontFamily: "OsWald"),
    );
  }
}

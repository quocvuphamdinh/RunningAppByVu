import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:running_app_flutter/config/res/app_color.dart';

class TextMore extends StatelessWidget {
  const TextMore({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "More",
      style: TextStyle(
          color: AppColor.yellow, fontWeight: FontWeight.bold, fontSize: 16.sp),
    );
  }
}

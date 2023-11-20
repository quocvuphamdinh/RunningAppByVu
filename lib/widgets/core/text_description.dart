import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextDescription extends StatelessWidget {
  const TextDescription({super.key, required this.text, this.textColor});

  final String text;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: textColor,
          fontSize: 18.sp,
          fontFamily: "OsWald",
          fontWeight: FontWeight.bold),
    );
  }
}

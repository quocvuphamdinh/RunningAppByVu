import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextDescription extends StatelessWidget {
  const TextDescription({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 18.sp, fontFamily: "OsWald", fontWeight: FontWeight.bold),
    );
  }
}

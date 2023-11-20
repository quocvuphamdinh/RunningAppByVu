import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:running_app_flutter/config/res/app_color.dart';

class RunButtonCircle extends StatelessWidget {
  const RunButtonCircle(
      {super.key,
      this.backgroundColor,
      this.gradients,
      required this.child,
      required this.onClick});

  final Color? backgroundColor;
  final List<Color>? gradients;
  final Widget child;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 80.h,
        width: 80.w,
        decoration: BoxDecoration(
            color: backgroundColor ?? AppColor.primaryColor,
            boxShadow: const [
              BoxShadow(
                blurStyle: BlurStyle.solid,
                color: AppColor.grey300,
                offset: Offset(0.0, 1.0),
                blurRadius: 5.0,
              ),
            ],
            shape: BoxShape.circle,
            gradient:
                gradients != null ? LinearGradient(colors: gradients!) : null),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

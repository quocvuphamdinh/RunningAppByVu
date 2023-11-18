import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:running_app_flutter/components/components.dart';

class RunTextNoData extends StatelessWidget {
  const RunTextNoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Components.SVGIcon(path: 'assets/svg/no_data.svg', size: 300.h),
          Text("No data to show", style: TextStyle(fontSize: 20.sp))
        ],
      ),
    );
  }
}

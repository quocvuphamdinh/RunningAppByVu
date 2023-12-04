import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/presentation/home/profile/run_history/run_history_controller.dart';
import 'package:running_app_flutter/presentation/home/profile/run_history/run_history_detail/run_history_detail_controller.dart';
import 'package:running_app_flutter/presentation/home/profile/run_history/widgets/run_history_item.dart';
import 'package:running_app_flutter/routes/app_routes.dart';
import 'package:running_app_flutter/widgets/core/run_text_drop_down.dart';

class RunOnlyOrWithExercisePage extends GetView<RunHistoryController> {
  const RunOnlyOrWithExercisePage({super.key, required this.isRunWithExercise});

  final bool isRunWithExercise;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.grey80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimens.smallSpacingHor,
                vertical: AppDimens.smallSpacingVer),
            child: Row(
              children: [
                Text("Sort by:", style: TextStyle(fontSize: 16.sp)),
                SizedBox(width: AppDimens.size10),
                Expanded(
                  child: RunTextDropDown(
                      backgroundColor: AppColor.whiteColor,
                      onSelectedValue: ((selectedValue) {}),
                      listOptions: [
                        RunTextDropDownModel(name: "Date", value: "0"),
                        RunTextDropDownModel(name: "Running Time", value: "1"),
                        RunTextDropDownModel(
                            name: "Calories Burned", value: "2"),
                        RunTextDropDownModel(name: "Distance", value: "3"),
                        RunTextDropDownModel(name: "Average Speed", value: "4")
                      ]),
                )
              ],
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: Obx(() {
                var runs = !isRunWithExercise
                    ? controller.runsOnly
                    : controller.runWithExercises;
                return ListView.builder(
                    itemCount: runs.length,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        onTap: () {
                          Get.toNamed(
                              AppRoutes.RunHistoryDetail,
                              arguments: {"run_id": runs[index].id});
                          
                        },
                        child: RunHistoryItem(
                          run: runs[index],
                        ),
                      );
                    }));
              }),
            ),
          )
        ],
      ),
    );
  }
}

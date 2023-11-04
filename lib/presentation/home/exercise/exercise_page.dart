import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/config/res/app_image.dart';
import 'package:running_app_flutter/presentation/home/exercise/exercise_controller.dart';
import 'package:running_app_flutter/presentation/home/exercise/widget/exercise_item.dart';
import 'package:running_app_flutter/widgets/appbar/app_bar_two_side.dart';
import 'package:running_app_flutter/widgets/core/text_description.dart';
import 'package:running_app_flutter/widgets/core/text_more.dart';
import 'package:running_app_flutter/widgets/core/text_title.dart';

class ExercisePage extends GetView<ExerciseController> {
  const ExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarTwoSide(
            widgetLeft: const TextTitle(
              text: "Activities",
            ),
            widgetRight: Image(
              image: AppImages.logoImage,
              width: AppDimens.iconLargeSize,
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppDimens.aBitSpacingHor),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: AppDimens.smallSpacingVer),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextDescription(
                            text: "Walking exercise",
                          ),
                          TextMore()
                        ],
                      ),
                    ),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return ExerciseItem(
                              exerciseItem: controller.walkingExercises[index]);
                        }),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: AppDimens.smallSpacingVer,
                          top: AppDimens.smallSpacingVer),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextDescription(
                            text: "Running exercise",
                          ),
                          TextMore()
                        ],
                      ),
                    ),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return ExerciseItem(
                              exerciseItem: controller.runningExercises[index]);
                        })
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}

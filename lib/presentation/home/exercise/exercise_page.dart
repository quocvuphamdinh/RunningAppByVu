import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/config/res/app_image.dart';
import 'package:running_app_flutter/constant/constant.dart';
import 'package:running_app_flutter/presentation/home/exercise/exercise_controller.dart';
import 'package:running_app_flutter/presentation/home/exercise/widget/exercise_item.dart';
import 'package:running_app_flutter/routes/app_routes.dart';
import 'package:running_app_flutter/widgets/appbar/app_bar_two_side.dart';
import 'package:running_app_flutter/widgets/core/run_text_no_data.dart';
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
          bottom: false,
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
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDimens.aBitSpacingHor),
                  child: SmartRefresher(
                    onRefresh: controller.onRefresh,
                    controller: controller.refreshController,
                    header: const WaterDropHeader(
                      refresh: CupertinoActivityIndicator(),
                      complete: Icon(Icons.check, color: AppColor.grey),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: AppDimens.smallSpacingVer),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const TextDescription(
                                  text: "Walking exercise",
                                ),
                                Obx(() => controller.walkingExercises.isNotEmpty
                                    ? GestureDetector(
                                        child: const TextMore(),
                                        onTap: () {
                                          Get.toNamed(AppRoutes.ExerciseList,
                                              arguments: {
                                                Constant.EXERCISE_TYPE:
                                                    Constant.WALKING,
                                                Constant.EXERCISE_TITLE:
                                                    "Walking for weight loss"
                                              });
                                        })
                                    : const SizedBox())
                              ],
                            ),
                          ),
                          Obx(() => !controller.isLoadingWalkingExercises.value
                              ? (controller.walkingExercises.isNotEmpty
                                  ? ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          controller.walkingExercises.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                                AppRoutes.ExerciseDetail,
                                                arguments: {
                                                  'exercise': controller
                                                      .walkingExercises[index]
                                                });
                                          },
                                          child: ExerciseItem(
                                              exerciseItem: controller
                                                  .walkingExercises[index]),
                                        );
                                      })
                                  : const RunTextNoData())
                              : const Center(
                                  child: CupertinoActivityIndicator())),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: AppDimens.smallSpacingVer,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const TextDescription(
                                  text: "Running exercise",
                                ),
                                Obx(() => controller.runningExercises.isNotEmpty
                                    ? GestureDetector(
                                        child: const TextMore(),
                                        onTap: () {
                                          Get.toNamed(AppRoutes.ExerciseList,
                                              arguments: {
                                                Constant.EXERCISE_TYPE:
                                                    Constant.RUNNING,
                                                Constant.EXERCISE_TITLE:
                                                    "Running for weight loss"
                                              });
                                        })
                                    : const SizedBox())
                              ],
                            ),
                          ),
                          Obx(() => !controller.isLoadingRunningExercises.value
                              ? (controller.runningExercises.isNotEmpty
                                  ? ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          controller.runningExercises.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                                AppRoutes.ExerciseDetail,
                                                arguments: {
                                                  'exercise': controller
                                                      .runningExercises[index]
                                                });
                                          },
                                          child: ExerciseItem(
                                              exerciseItem: controller
                                                  .runningExercises[index]),
                                        );
                                      })
                                  : const RunTextNoData())
                              : const Center(
                                  child: CupertinoActivityIndicator()))
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

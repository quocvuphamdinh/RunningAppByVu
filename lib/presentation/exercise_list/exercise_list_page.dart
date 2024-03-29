import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/presentation/exercise_list/exercise_list_controller.dart';
import 'package:running_app_flutter/presentation/home/exercise/widget/exercise_item.dart';
import 'package:running_app_flutter/routes/app_routes.dart';
import 'package:running_app_flutter/widgets/appbar/app_bar_two_side.dart';
import 'package:running_app_flutter/widgets/core/run_text_no_data.dart';
import 'package:running_app_flutter/widgets/core/text_description.dart';
import 'package:running_app_flutter/widgets/core/text_title.dart';

class ExerciseListPage extends GetView<ExerciseListController> {
  const ExerciseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarTwoSide(
            widgetLeft: const TextTitle(text: "Training plans"),
            widgetRight: Icon(Icons.close, size: AppDimens.iconSmallSize),
            onCLickWidgetRight: () {
              if (!controller.isLoading.value) {
                Get.back();
                Get.delete<ExerciseListController>();
              }
            },
          ),
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppDimens.smallSpacingHor),
              child: Column(
                children: [
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextTitle(text: controller.exerciseTitle.value),
                          TextDescription(
                              text:
                                  "${controller.totalExerciseCompleted}/${controller.totalExercise}")
                        ],
                      )),
                  SizedBox(height: AppDimens.size20),
                  Expanded(
                    child: Obx(() => !controller.isLoading.value
                        ? (controller.exercises.isNotEmpty
                            ? ScrollConfiguration(
                                behavior: const ScrollBehavior()
                                    .copyWith(overscroll: false),
                                child: ListView.builder(
                                    itemCount: controller.exercises.length,
                                    itemBuilder: ((context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.ExerciseDetail,
                                              arguments: {
                                                'exercise':
                                                    controller.exercises[index]
                                              });
                                        },
                                        child: ExerciseItem(
                                            exerciseItem:
                                                controller.exercises[index]),
                                      );
                                    })))
                            : const RunTextNoData())
                        : const Center(child: CupertinoActivityIndicator())),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}

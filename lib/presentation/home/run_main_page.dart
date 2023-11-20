import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';
import 'package:running_app_flutter/config/res/app_image.dart';
import 'package:running_app_flutter/presentation/home/analysis/analysis_page.dart';
import 'package:running_app_flutter/presentation/home/exercise/exercise_page.dart';
import 'package:running_app_flutter/presentation/home/home_page/home_page.dart';
import 'package:running_app_flutter/presentation/home/profile/profile_page.dart';
import 'package:running_app_flutter/presentation/home/run_main_controller.dart';
import 'package:running_app_flutter/routes/app_routes.dart';

class RunMainPage extends GetView<RunMainController> {
  const RunMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        extendBody: true,
        floatingActionButton: FloatingActionButton(
            backgroundColor: AppColor.grey100,
            onPressed: () {
              Get.toNamed(AppRoutes.ExecuteRun);
            },
            child: const Image(image: AppImages.icRun)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: AppColor.grey300,
          shape: const CircularNotchedRectangle(),
          notchMargin: 5,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    controller.onSelectedPage(RunMainController.HOME_INDEX);
                  },
                  icon: Icon(
                    Icons.home,
                    color: controller.selectedPage.value ==
                            RunMainController.HOME_INDEX
                        ? AppColor.endColor3
                        : AppColor.whiteColor,
                  )),
              IconButton(
                icon: Image(
                  image: AppImages.icList,
                  color: controller.selectedPage.value ==
                          RunMainController.EXERCISE_INDEX
                      ? AppColor.endColor3
                      : AppColor.whiteColor,
                  width: AppDimens.iconSmallSize,
                ),
                onPressed: () {
                  controller.onSelectedPage(RunMainController.EXERCISE_INDEX);
                },
              ),
              const SizedBox(),
              IconButton(
                icon: Image(
                  image: AppImages.icAnalysis,
                  color: controller.selectedPage.value ==
                          RunMainController.ANALYSIS_INDEX
                      ? AppColor.endColor3
                      : AppColor.whiteColor,
                  width: AppDimens.iconSmallSize,
                ),
                onPressed: () {
                  controller.onSelectedPage(RunMainController.ANALYSIS_INDEX);
                },
              ),
              IconButton(
                  onPressed: () {
                    controller.onSelectedPage(RunMainController.PROFILE_INDEX);
                  },
                  icon: Icon(
                    Icons.person,
                    color: controller.selectedPage.value ==
                            RunMainController.PROFILE_INDEX
                        ? AppColor.endColor3
                        : AppColor.whiteColor,
                  ))
            ],
          ),
        ),
        backgroundColor: AppColor.appBackgroundColor,
        body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: IndexedStack(
            index: controller.selectedPage.value,
            children: const [
              HomePage(),
              ExercisePage(),
              AnalysisPage(),
              ProfilePage()
            ],
          ),
        )));
  }
}

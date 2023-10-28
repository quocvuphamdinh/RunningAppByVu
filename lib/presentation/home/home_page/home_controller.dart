import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/config/res/app_image.dart';
import 'package:running_app_flutter/presentation/home/home_page/widget/recent_activity_item.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class HomeController extends BaseController {
  final List<RecentActivityModel> recentActivites = [
    RecentActivityModel(
        image: AppImages.walkingBackground,
        title: "Week 1 Day 1",
        runDateTime: "May 29, 16:31",
        distance: 0,
        runTime: "00:15",
        averageSpeed: 0,
        caloriesBurned: 0),
    RecentActivityModel(
        image: AppImages.activityBackground,
        title: "Week 1 Day 2",
        iconStatus: AppImages.icTired,
        runDateTime: "May 26, 20:53",
        distance: 0.249,
        runTime: "00:57",
        averageSpeed: 16.1,
        caloriesBurned: 19)
  ];
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}

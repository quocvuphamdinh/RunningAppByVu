import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/models/run.dart';

class RunHistoryDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RunHistoryDetailController());
  }
}

class RunHistoryDetailController extends BaseController {
  Rx<Run?> run = (null as Run?).obs;
  @override
  void onInit() {
    super.onInit();

    run.value = Run(
        timestamp: 1699953010,
        averageSpeedInKilometersPerHour: 10.2,
        distanceInKilometers: 2000,
        timeInMillis: 2000,
        caloriesBurned: 5,
        isRunWithExercise: 0);
  }
}

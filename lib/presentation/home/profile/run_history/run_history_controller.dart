import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/models/run.dart';

class RunHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RunHistoryController());
  }
}

class RunHistoryController extends BaseController {
  RxList<Run> runsOnly = <Run>[].obs;
  RxList<Run> runWithExercises = <Run>[].obs;
  @override
  void onInit() {
    super.onInit();

    runsOnly.value = [
      Run(
          timestamp: 1699953010,
          averageSpeedInKilometersPerHour: 10.2,
          distanceInKilometers: 2000,
          timeInMillis: 2000,
          caloriesBurned: 5,
          isRunWithExercise: 0),
      Run(
          timestamp: 1699866680,
          averageSpeedInKilometersPerHour: 12.2,
          distanceInKilometers: 3000,
          timeInMillis: 3000,
          caloriesBurned: 10,
          isRunWithExercise: 0)
    ];

    runWithExercises.value = [
      Run(
          timestamp: 1699953010,
          averageSpeedInKilometersPerHour: 10.2,
          distanceInKilometers: 6000,
          timeInMillis: 2000,
          caloriesBurned: 5,
          isRunWithExercise: 0),
      Run(
          timestamp: 1699866680,
          averageSpeedInKilometersPerHour: 12.2,
          distanceInKilometers: 10000,
          timeInMillis: 3000,
          caloriesBurned: 10,
          isRunWithExercise: 0),
      Run(
          timestamp: 1699866680,
          averageSpeedInKilometersPerHour: 12.2,
          distanceInKilometers: 10000,
          timeInMillis: 3000,
          caloriesBurned: 10,
          isRunWithExercise: 0)
    ];
  }
}

import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/data/models/activity.dart';
import 'package:running_app_flutter/data/models/workout.dart';

class ExerciseDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExerciseDetailController(), fenix: true);
  }
}

class ExerciseDetailController extends BaseController {
  Rx<Activity?> exercise = (null as Activity?).obs;
  RxList<Workout> workouts = <Workout>[].obs;
  @override
  void onInit() {
    super.onInit();

    exercise.value = Get.arguments['exercise'] as Activity;
    workouts.value = exercise.value!.workouts;
  }

  onBack() {
    Get.delete<ExerciseDetailController>();
    Get.back();
  }
}

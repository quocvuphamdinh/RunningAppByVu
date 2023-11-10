import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/models/workout.dart';

class ExerciseDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExerciseDetailController());
  }
}

class ExerciseDetailController extends BaseController {
  List<Workout> workouts = [
    Workout(name: "Run", duration: 960000),
    Workout(name: "Walk", duration: 60000),
    Workout(name: "Cool down", duration: 60000)
  ];
  @override
  void onInit() {
    super.onInit();
  }
}

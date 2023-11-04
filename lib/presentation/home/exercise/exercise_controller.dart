import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/presentation/home/exercise/widget/exercise_item.dart';

class ExerciseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExerciseController());
  }
}

class ExerciseController extends BaseController {
  final walkingExercises = [
    ExerciseItemModel(activityType: 2, title: "Week 1 Day 1", minuteNumber: 17),
    ExerciseItemModel(activityType: 2, title: "Week 1 Day 2", minuteNumber: 17),
    ExerciseItemModel(activityType: 2, title: "Week 1 Day 3", minuteNumber: 34),
    ExerciseItemModel(activityType: 2, title: "Week 1 Day 4", minuteNumber: 16),
  ];
  final runningExercises = [
    ExerciseItemModel(activityType: 1, title: "Week 1 Day 1", minuteNumber: 17),
    ExerciseItemModel(activityType: 1, title: "Week 1 Day 2", minuteNumber: 17),
    ExerciseItemModel(activityType: 1, title: "Week 1 Day 3", minuteNumber: 34),
    ExerciseItemModel(activityType: 1, title: "Week 1 Day 4", minuteNumber: 16),
  ];
  @override
  void onInit() {
    super.onInit();
  }
}

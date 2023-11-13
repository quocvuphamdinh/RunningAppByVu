import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/constant/constant.dart';
import 'package:running_app_flutter/models/activity.dart';
import 'package:running_app_flutter/models/workout.dart';

class ExerciseListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExerciseListController());
  }
}

class ExerciseListController extends BaseController {
  dynamic argumentData = Get.arguments;

  RxInt exerciseType = Constant.RUNNING.obs;
  RxString exerciseTitle = "Exercise List".obs;
  RxInt totalExerciseCompleted = 0.obs;
  RxInt totalExercise = 0.obs;

  final walkingExercises = [
    Activity(
        name: "Week 1 Day 1",
        type: 0,
        durationOfWorkouts: 1200000,
        workouts: [
          Workout(name: "Run", duration: 60000),
          Workout(name: "Walk", duration: 60000),
          Workout(name: "Cool down", duration: 60000),
        ],
        isCompleted: 0),
    Activity(
        name: "Week 1 Day 2",
        type: 0,
        durationOfWorkouts: 600000,
        workouts: [
          Workout(name: "Run", duration: 60000),
          Workout(name: "Walk", duration: 60000),
        ],
        isCompleted: 0)
  ];

  final runningExercises = [
    Activity(
        name: "Week 1 Day 1",
        type: 1,
        durationOfWorkouts: 1200000,
        workouts: [
          Workout(name: "Run", duration: 60000),
          Workout(name: "Walk", duration: 60000),
          Workout(name: "Cool down", duration: 60000),
        ],
        isCompleted: 0),
    Activity(
        name: "Week 1 Day 2",
        type: 1,
        durationOfWorkouts: 600000,
        workouts: [
          Workout(name: "Run", duration: 60000),
          Workout(name: "Walk", duration: 60000),
        ],
        isCompleted: 1)
  ];

  @override
  void onInit() {
    super.onInit();

    exerciseType.value =
        argumentData[Constant.EXERCISE_TYPE] ?? Constant.RUNNING;
    exerciseTitle.value =
        argumentData[Constant.EXERCISE_TITLE] ?? exerciseTitle.value;

    onInitDataTotal();
  }

  onInitDataTotal() {
    var totalCompleted = 0;
    if (exerciseType.value == Constant.RUNNING) {
      for (var item in runningExercises) {
        if (item.isCompleted == 1) {
          totalCompleted += 1;
        }
      }
    } else {
      for (var item in walkingExercises) {
        if (item.isCompleted == 1) {
          totalCompleted += 1;
        }
      }
    }
    totalExerciseCompleted.value = totalCompleted;
    totalExercise.value = exerciseType.value == Constant.RUNNING
        ? runningExercises.length
        : walkingExercises.length;
  }
}

import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/data/models/activity.dart';
import 'package:running_app_flutter/data/models/workout.dart';

class ExerciseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExerciseController());
  }
}

class ExerciseController extends BaseController {
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
        isCompleted: 0)
  ];
  // final walkingExercises = [
  //   ExerciseItemModel(activityType: 2, title: "Week 1 Day 1", minuteNumber: 17),
  //   ExerciseItemModel(activityType: 2, title: "Week 1 Day 2", minuteNumber: 17),
  //   ExerciseItemModel(activityType: 2, title: "Week 1 Day 3", minuteNumber: 34),
  //   ExerciseItemModel(activityType: 2, title: "Week 1 Day 4", minuteNumber: 16),
  // ];
  // final runningExercises = [
  //   ExerciseItemModel(activityType: 1, title: "Week 1 Day 1", minuteNumber: 17),
  //   ExerciseItemModel(activityType: 1, title: "Week 1 Day 2", minuteNumber: 17),
  //   ExerciseItemModel(activityType: 1, title: "Week 1 Day 3", minuteNumber: 34),
  //   ExerciseItemModel(activityType: 1, title: "Week 1 Day 4", minuteNumber: 16),
  // ];
  @override
  void onInit() {
    super.onInit();
  }
}

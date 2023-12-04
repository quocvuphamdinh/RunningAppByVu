import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/data/models/activity.dart';
import 'package:running_app_flutter/data/models/run.dart';
import 'package:running_app_flutter/data/models/user_activity_detail.dart';
import 'package:running_app_flutter/data/models/workout.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class HomeController extends BaseController {
  final List<UserActivityDetail> recentActivites = [
    UserActivityDetail(
        run: Run(
            timestamp: 1699866049,
            averageSpeedInKilometersPerHour: 16.7,
            distanceInKilometers: 2222,
            timeInMillis: 60000,
            caloriesBurned: 10,
            isRunWithExercise: 1),
        comment: "hi vũ",
        mood: 1,
        activity: Activity(
            name: "Week 1 Day 1",
            type: 0,
            durationOfWorkouts: 60000,
            workouts: [Workout(name: "Run", duration: 60000)],
            isCompleted: 1)),
    UserActivityDetail(
        run: Run(
            timestamp: 1699866049,
            averageSpeedInKilometersPerHour: 18,
            distanceInKilometers: 2500,
            timeInMillis: 120000,
            caloriesBurned: 15,
            isRunWithExercise: 1),
        comment: "hi vũ 2",
        mood: 2,
        activity: Activity(
            name: "Week 1 Day 2",
            type: 1,
            durationOfWorkouts: 60000,
            workouts: [Workout(name: "Run", duration: 60000)],
            isCompleted: 1)),
    UserActivityDetail(
        run: Run(
            timestamp: 1699866049,
            averageSpeedInKilometersPerHour: 20.65,
            distanceInKilometers: 3000,
            timeInMillis: 180000,
            caloriesBurned: 20,
            isRunWithExercise: 1),
        comment: "hi vũ 3",
        mood: 3,
        activity: Activity(
            name: "Week 1 Day 3",
            type: 0,
            durationOfWorkouts: 60000,
            workouts: [Workout(name: "Run", duration: 60000)],
            isCompleted: 1))
  ];
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}

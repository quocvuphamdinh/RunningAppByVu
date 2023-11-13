import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/models/activity.dart';
import 'package:running_app_flutter/models/run.dart';
import 'package:running_app_flutter/models/user_activity_detail.dart';
import 'package:running_app_flutter/models/workout.dart';

class RecentExerciseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecentExerciseController());
  }
}

class RecentExerciseController extends BaseController {
  final List<UserActivityDetail> recentActivites = [
    UserActivityDetail(
        run: Run(
            timestamp: 1699843990,
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
            timestamp: 1699843990,
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
            timestamp: 1699843990,
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
            isCompleted: 1)),
    UserActivityDetail(
        run: Run(
            timestamp: 1699843990,
            averageSpeedInKilometersPerHour: 20.65,
            distanceInKilometers: 3000,
            timeInMillis: 180000,
            caloriesBurned: 20,
            isRunWithExercise: 1),
        activity: Activity(
            name: "Week 1 Day 3",
            type: 0,
            durationOfWorkouts: 60000,
            workouts: [Workout(name: "Run", duration: 60000)],
            isCompleted: 1))
  ];

  final RxDouble totalKm = 0.0.obs;
  final RxInt totalDuration = 0.obs;
  final RxInt totalCalories = 0.obs;
  final RxDouble totalAvgSpeed = 0.0.obs;

  @override
  void onInit() {
    super.onInit();

    onInitTotalData();
  }

  onInitTotalData() {
    var km = 0;
    var duration = 0;
    var calories = 0;
    var avgSpeed = 0.0;
    for (var element in recentActivites) {
      km += element.run.distanceInKilometers;
      duration += element.run.timeInMillis;
      calories += element.run.caloriesBurned;
      avgSpeed += element.run.averageSpeedInKilometersPerHour;
    }

    totalKm.value = km / 1000;
    totalDuration.value = duration;
    totalCalories.value = calories;
    totalAvgSpeed.value = avgSpeed;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/data/models/activity.dart';
import 'package:running_app_flutter/data/models/run.dart';
import 'package:running_app_flutter/data/models/user_activity_detail.dart';
import 'package:running_app_flutter/data/models/workout.dart';

class ResultExerciseRunBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResultExerciseRunController());
  }
}

class ResultExerciseRunController extends BaseController {
  late TextEditingController textAddNoteController;
  late Rx<UserActivityDetail?> userActivityDetail =
      (null as UserActivityDetail?).obs;
  @override
  void onInit() {
    super.onInit();

    textAddNoteController = TextEditingController();

    userActivityDetail.value = UserActivityDetail(
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
            isCompleted: 1));

    onEditNote();
  }

  onClickChangeMood(int mood) {
    userActivityDetail.value!.mood = mood;
    userActivityDetail.refresh();
  }

  onEditNote() {
    textAddNoteController.text = userActivityDetail.value == null
        ? ""
        : userActivityDetail.value!.comment ?? "";
  }

  @override
  void onClose() {
    textAddNoteController.dispose();
    super.onClose();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/data/models/user_activity_detail.dart';

class ResultExerciseRunBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResultExerciseRunController(), fenix: true);
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

    var data = Get.arguments['result_exercise_run'] as UserActivityDetail;
    userActivityDetail.value = data;

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

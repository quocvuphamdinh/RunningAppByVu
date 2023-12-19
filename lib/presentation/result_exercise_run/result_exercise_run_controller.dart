import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/constant/constant.dart';
import 'package:running_app_flutter/data/models/user_activity.dart';
import 'package:running_app_flutter/data/models/user_activity_detail.dart';
import 'package:running_app_flutter/data/repositories/impl/user_exercise_repository_impl.dart';
import 'package:running_app_flutter/data/repositories/user_exercise_repository.dart';
import 'package:running_app_flutter/models/data_state.dart';
import 'package:running_app_flutter/services/local_storage.dart';

class ResultExerciseRunBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>
        ResultExerciseRunController(Get.find<UserExerciseRepositoryImpl>()));
  }
}

class ResultExerciseRunController extends BaseController {
  final UserExerciseRepository _userExerciseRepository;
  ResultExerciseRunController(this._userExerciseRepository);

  final store = Get.find<LocalStorageService>();

  late TextEditingController textAddNoteController;
  late Rx<UserActivityDetail?> userActivityDetail =
      (null as UserActivityDetail?).obs;

  UserActivity? userActivity;
  @override
  void onInit() {
    super.onInit();

    textAddNoteController = TextEditingController();

    var data = Get.arguments['result_exercise_run'] as UserActivityDetail;
    userActivityDetail.value = data;
    userActivity = UserActivity(
        id: data.id!,
        activityId: data.activity.id!,
        run: data.run,
        comment: data.comment ?? "",
        mood: data.mood ?? 0);

    onEditNote();
  }

  onDeleteExercise() {
    showAppDialog(
        title: Constant.TITLE_ALERT,
        content: "Do you want delete this exercise run ?",
        button: "Yes",
        onPressed: () async {
          showLoading(messaging: "Deleting...");

          final data = await _userExerciseRepository.deleteUserExercise(
              userActivityId: userActivity!.id!);
          if (data is DataFailed) {
            if (isShowLoading()) {
              dismissLoading();
            }
            showAppDialog(
                title: Constant.TITLE_ALERT,
                content: data.error!.errorMsg,
                button: "OK");
            return;
          }
          if (isShowLoading()) {
            dismissLoading();
          }
          Get.back(result: {"update_result_exercise": data.data!["success"]!});
        });
  }

  onSave() async {
    showLoading(messaging: "Updating...");
    userActivity = UserActivity(
        id: userActivityDetail.value!.id!,
        activityId: userActivityDetail.value!.activity.id!,
        run: userActivityDetail.value!.run,
        comment: textAddNoteController.text.trim(),
        mood: userActivityDetail.value!.mood ?? 0);
    final data = await _userExerciseRepository.updateUserExercise(
        userActivity: userActivity!, userId: store.user!.id!);
    if (data is DataFailed) {
      if (isShowLoading()) {
        dismissLoading();
      }
      showAppDialog(
          title: Constant.TITLE_ALERT,
          content: data.error!.errorMsg,
          button: "OK");
      return;
    }
    if (isShowLoading()) {
      dismissLoading();
    }
    Get.back(result: {"update_result_exercise": true});
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
    textAddNoteController.clear();
    textAddNoteController.dispose();
    super.onClose();
  }
}

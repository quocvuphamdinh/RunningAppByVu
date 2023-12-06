import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/constant/constant.dart';

class WeeklyGoalSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WeeklyGoalSettingController(), fenix: true);
  }
}

class WeeklyGoalSettingController extends BaseController {
  RxInt selectedGoal = 1.obs;
  @override
  void onInit() {
    super.onInit();

    selectedGoal.value = Get.arguments[Constant.INTENT_SET_MYGOAL] as int;
  }

  onSelectedGoalValue(int value) {
    selectedGoal.value = value;
  }

  onBackWithResult() {
    selectedGoal.value = selectedGoal.value == 0 ? 1 : selectedGoal.value;
    Get.delete<WeeklyGoalSettingController>();
    Get.back(result: selectedGoal.value);
  }

  onBack() {
    Get.delete<WeeklyGoalSettingController>();
    Get.back();
  }
}

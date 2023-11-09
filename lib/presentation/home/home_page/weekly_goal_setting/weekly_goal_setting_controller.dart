import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';

class WeeklyGoalSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WeeklyGoalSettingController());
  }
}

class WeeklyGoalSettingController extends BaseController {
  RxInt selectedGoal = 1.obs;
  @override
  void onInit() {
    super.onInit();
  }

  onSelectedGoalValue(int value) {
    selectedGoal.value = value;
  }
}

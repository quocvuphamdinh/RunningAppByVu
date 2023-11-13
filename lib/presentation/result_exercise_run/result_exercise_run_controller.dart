import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';

class ResultExerciseRunBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResultExerciseRunController());
  }
}

class ResultExerciseRunController extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }
}

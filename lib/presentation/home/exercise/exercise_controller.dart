import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';

class ExerciseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExerciseController());
  }
}

class ExerciseController extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }
}

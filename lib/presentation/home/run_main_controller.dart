import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';

class RunMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RunMainController());
  }
}

class RunMainController extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }
}

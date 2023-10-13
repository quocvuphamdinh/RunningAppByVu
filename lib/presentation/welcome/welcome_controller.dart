import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';

class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WelcomeController());
  }
}

class WelcomeController extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }
}

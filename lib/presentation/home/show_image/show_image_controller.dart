import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';

class ShowImageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShowImageController());
  }
}

class ShowImageController extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }
}

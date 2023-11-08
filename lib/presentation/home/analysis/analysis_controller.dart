import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';

class AnalysisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AnalysisController());
  }
}

class AnalysisController extends BaseController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}

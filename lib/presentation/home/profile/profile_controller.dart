import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}

class ProfileController extends BaseController {}

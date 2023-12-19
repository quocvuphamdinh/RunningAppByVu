import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';

class ShowImageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShowImageController(), fenix: true);
  }
}

class ShowImageController extends BaseController {
  RxString imageUrl = "".obs;
  @override
  void onInit() {
    super.onInit();

    imageUrl.value = Get.arguments['image_url'] as String;
  }
}

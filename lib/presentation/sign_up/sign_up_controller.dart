import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController());
  }
}

class SignUpController extends BaseController {
  late TextEditingController textEmailController;
  late TextEditingController textPasswordController;
  late TextEditingController textRepeatPasswordController;
  late TextEditingController textFullNameController;
  late TextEditingController textHeightController;
  late TextEditingController textWeightController;

  @override
  void onInit() {
    super.onInit();

    textEmailController = TextEditingController();
    textPasswordController = TextEditingController();
    textRepeatPasswordController = TextEditingController();
    textFullNameController = TextEditingController();
    textHeightController = TextEditingController();
    textWeightController = TextEditingController();
  }

  @override
  void onClose() {
    textEmailController.dispose();
    textPasswordController.dispose();
    textRepeatPasswordController.dispose();
    textFullNameController.dispose();
    textHeightController.dispose();
    textWeightController.dispose();
    super.onClose();
  }
}

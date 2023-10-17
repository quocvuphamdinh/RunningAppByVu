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

  RxString selectedValue = "Male".obs;

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

  void dropDownCallBack(String? selectedValue) {
    if (selectedValue is String) {
      this.selectedValue.value = selectedValue;
    }
  }
}

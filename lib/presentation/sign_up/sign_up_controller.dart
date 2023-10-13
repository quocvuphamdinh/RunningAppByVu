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
  final textEmailController = TextEditingController();
  final textPasswordController = TextEditingController();
  final textRepeatPasswordController = TextEditingController();
  final textFullNameController = TextEditingController();
  final textHeightController = TextEditingController();
  final textWeightController = TextEditingController();

  RxString selectedValue = "Male".obs;
  RxBool isHidePassword = true.obs;
  RxBool isHideRepeatPassword = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void dropDownCallBack(String? selectedValue) {
    if (selectedValue is String) {
      this.selectedValue.value = selectedValue;
    }
  }

  void showPassword() {
    isHidePassword.value = !isHidePassword.value;
  }

  void showRepeatPassword() {
    isHideRepeatPassword.value = !isHideRepeatPassword.value;
  }
}

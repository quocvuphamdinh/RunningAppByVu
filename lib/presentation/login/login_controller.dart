import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}

class LoginController extends BaseController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool isHidePassword = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void showPassword() {
    isHidePassword.value = !isHidePassword.value;
  }
}

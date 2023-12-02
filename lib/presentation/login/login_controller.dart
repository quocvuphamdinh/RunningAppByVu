import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/models/user.dart';
import 'package:running_app_flutter/services/local_storage.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}

class LoginController extends BaseController {
  final store = Get.find<LocalStorageService>();

  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void onInit() {
    super.onInit();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<bool> login() async {
    var email = emailController.text.trim();
    var password = passwordController.text.trim();
    var user = store.user;
    await Future.delayed(const Duration(seconds: 2));
    if (email == user?.userName && password == user?.passWord) {
      store.isLogin = true;
      return true;
    }
    return false;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

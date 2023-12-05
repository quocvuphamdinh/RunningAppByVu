import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/data/repositories/impl/user_repository_impl.dart';
import 'package:running_app_flutter/data/repositories/user_repository.dart';
import 'package:running_app_flutter/extensions/email_validator_extension.dart';
import 'package:running_app_flutter/models/data_state.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPasswordController(Get.find<UserRepositoryImpl>()));
  }
}

class ForgotPasswordController extends BaseController {
  final UserRepository _userRepo;
  ForgotPasswordController(this._userRepo);

  late TextEditingController emailController;
  @override
  void onInit() {
    super.onInit();

    emailController = TextEditingController();
  }

  onResetPass() async {
    showLoading(messaging: "Processing...");
    final email = emailController.text.trim();
    if (email.isEmpty) {
      dismissLoading();
      showAppDialog(
          title: "Reset password",
          content: "Email must not empty !",
          button: "OK");
      return;
    }
    if (!email.isValidEmail()) {
      dismissLoading();
      showAppDialog(
          title: "Reset password",
          content: "Email is not valid !",
          button: "OK");
      return;
    }
    final isAccountValid = await _userRepo.checkEmailAccount(username: email);
    if (isAccountValid is DataFailed) {
      dismissLoading();
      showAppDialog(
          title: isAccountValid.error!.errorTitle,
          content: isAccountValid.error!.errorMsg,
          button: "OK");
      return;
    }
    final user = isAccountValid.data!;
    if (user.userName.isEmpty) {
      dismissLoading();
      showAppDialog(
          title: "Reset password",
          content: "This email is not registered !",
          button: "OK");
      return;
    }
    final resetPass = await _userRepo.resetPassword(user: user);
    if (resetPass is DataFailed) {
      dismissLoading();
      showAppDialog(
          title: resetPass.error!.errorTitle,
          content: resetPass.error!.errorMsg,
          button: "OK");
      return;
    }
    dismissLoading();
    showAppDialog(
        dismissOnTap: false,
        title: "Reset password",
        content: resetPass.data!['message']!,
        button: "OK",
        onPressed: () {
          Get.back();
        });
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}

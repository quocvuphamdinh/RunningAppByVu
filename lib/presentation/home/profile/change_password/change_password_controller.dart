import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/constant/constant.dart';
import 'package:running_app_flutter/services/local_storage.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangePasswordController());
  }
}

class ChangePasswordController extends BaseController {
  final store = Get.find<LocalStorageService>();

  late TextEditingController oldPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  @override
  void onInit() {
    super.onInit();

    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  bool validate() {
    var oldPassword = oldPasswordController.text.trim();
    var newPassword = newPasswordController.text.trim();
    var confirmPassword = confirmPasswordController.text.trim();
    var validateStr = "";
    if (store.user!.passWord != oldPassword) {
      validateStr = "Old password not correct !";
    } else if (newPassword.isEmpty || newPassword.length < 5) {
      validateStr = "New password must have length greater than 5 !";
    } else if (newPassword != confirmPassword) {
      validateStr = "Confirm password does not match with new password !";
    }

    if (validateStr.isNotEmpty) {
      showAppDialog(
          title: Constant.TITLE_ALERT, button: "OK", content: validateStr);
      return false;
    }
    return true;
  }

  onSave() {
    showLoading(messaging: "Loading...");
    bool isValid = validate();
    if (!isValid) {
      if (isShowLoading()) {
        dismissLoading();
      }
      return;
    }
    var newPassword = newPasswordController.text.trim();
    var user = store.user!;
    user.passWord = newPassword;
    store.user = user;

    if (isShowLoading()) {
      dismissLoading();
    }
    showAppDialog(
        title: Constant.TITLE_ALERT,
        button: "OK",
        content: "Change password successfully !",
        dismissOnTap: false,
        onPressed: () {
          onBack();
        });
  }

  onBack() {
    Get.back();
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}

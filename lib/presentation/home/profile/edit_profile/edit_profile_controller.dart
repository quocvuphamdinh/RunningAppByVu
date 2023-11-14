import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/models/user.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditProfileController());
  }
}

class EditProfileController extends BaseController {
  late TextEditingController usernameController;
  late TextEditingController fullnameController;
  late TextEditingController heightController;
  late TextEditingController weightController;

  Rx<User?> user = (null as User?).obs;

  @override
  void onInit() {
    super.onInit();

    onInitTextEditingControllers();

    user.value = User(
        userName: "quocvu22",
        passWord: "123",
        fullName: "Phạm Đình Quốc Vũ",
        gender: "Male",
        weight: 180,
        height: 70);

    bindUserDataToTextEditingController();
  }

  bindUserDataToTextEditingController() {
    if (user.value != null) {
      usernameController.text = user.value!.userName;
      fullnameController.text = user.value!.fullName;
      heightController.text = user.value!.height.toString();
      weightController.text = user.value!.weight.toString();
    }
  }

  onInitTextEditingControllers() {
    usernameController = TextEditingController();
    fullnameController = TextEditingController();
    heightController = TextEditingController();
    weightController = TextEditingController();
  }

  onDisposeTextEditingControllers() {
    usernameController.dispose();
    fullnameController.dispose();
    heightController.dispose();
    weightController.dispose();
  }

  @override
  void onClose() {
    onDisposeTextEditingControllers();
    super.onClose();
  }
}

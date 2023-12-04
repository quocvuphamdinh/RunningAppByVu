import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/constant/constant.dart';
import 'package:running_app_flutter/data/models/user.dart';
import 'package:running_app_flutter/services/local_storage.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditProfileController());
  }
}

class EditProfileController extends BaseController {
  final store = Get.find<LocalStorageService>();

  late TextEditingController usernameController;
  late TextEditingController fullnameController;
  late TextEditingController heightController;
  late TextEditingController weightController;
  late String gender;

  Rx<User?> user = (null as User?).obs;

  @override
  void onInit() {
    super.onInit();

    onInitTextEditingControllers();

    user.value = store.user;
    if (user.value != null) {
      gender = user.value!.gender;
    }

    bindUserDataToTextEditingController();
  }

  String validate(
      {required String fullname,
      required String height,
      required String weight}) {
    if (!fullname.isNotEmpty) {
      return "Fullname must not empty !";
    }
    if (!gender.isNotEmpty) {
      return "You must choose gender !";
    }
    if (!height.isNotEmpty) {
      return "Height must not empty ! (cm)";
    }
    if (!height.isNumericOnly) {
      return "Height must be integer number ! (cm)";
    }
    if (!weight.isNotEmpty) {
      return "Weight must not empty ! (kg)";
    }
    if (!weight.isNumericOnly) {
      return "Weight must be integer number ! (kg)";
    }

    return "";
  }

  edit() async {
    showLoading(messaging: "Editing...");
    var fullname = fullnameController.text.trim();
    var height = heightController.text.trim();
    var weight = weightController.text.trim();
    var validStr = validate(fullname: fullname, height: height, weight: weight);
    if (validStr.isEmpty) {
      var userUpdate = store.user;
      if (userUpdate != null) {
        userUpdate.fullName = fullname;
        userUpdate.gender = gender;
        userUpdate.height = int.parse(height);
        userUpdate.weight = int.parse(weight);
        store.user = userUpdate;
        await Future.delayed(const Duration(seconds: 2));
        dismissLoading();
        Get.back(result: {Constant.EDIT_PROFILE_SUCCESS: true});
      }
    } else {
      dismissLoading();
      showAppDialog(title: "Edit Profile", button: "OK", content: validStr);
    }
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

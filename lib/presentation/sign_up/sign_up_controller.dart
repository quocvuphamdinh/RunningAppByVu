import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/extensions/email_validator_extension.dart';
import 'package:running_app_flutter/models/user.dart';
import 'package:running_app_flutter/routes/app_routes.dart';
import 'package:running_app_flutter/services/local_storage.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController());
  }
}

class SignUpController extends BaseController {
  final store = Get.find<LocalStorageService>();

  late TextEditingController textEmailController;
  late TextEditingController textPasswordController;
  late TextEditingController textRepeatPasswordController;
  late TextEditingController textFullNameController;
  late TextEditingController textHeightController;
  late TextEditingController textWeightController;
  var gender = "";

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

  String validate(
      {required String email,
      required String password,
      required String repeatPassword,
      required String fullname,
      required String height,
      required String weight}) {
    if (!email.isValidEmail()) {
      return "Email is not valid !";
    }
    if (!password.isNotEmpty) {
      return "Password must not empty !";
    }
    if (!repeatPassword.isNotEmpty) {
      return "Repeat password must not empty !";
    }
    if (!(repeatPassword == password)) {
      return "Repeat password does not match password !";
    }
    if (!fullname.isNotEmpty) {
      return "Fullname must not empty !";
    }
    if (!gender.isNotEmpty) {
      return "You must choose gender !";
    }
    if (!height.isNotEmpty) {
      return "Height must not empty !";
    }
    if (!height.isNumericOnly) {
      return "Height must be number !";
    }
    if (!weight.isNotEmpty) {
      return "Weight must not empty !";
    }
    if (!weight.isNumericOnly) {
      return "Weight must be number !";
    }

    return "";
  }

  register() {
    var email = textEmailController.text.trim();
    var password = textPasswordController.text.trim();
    var repeatPassword = textRepeatPasswordController.text.trim();
    var fullname = textFullNameController.text.trim();
    var height = textHeightController.text.trim();
    var weight = textWeightController.text.trim();
    var validateStr = validate(
        email: email,
        password: password,
        repeatPassword: repeatPassword,
        fullname: fullname,
        height: height,
        weight: weight);
    if (validateStr.isEmpty) {
      var user = User(
          userName: email,
          passWord: password,
          fullName: fullname,
          gender: gender,
          weight: int.parse(weight),
          height: int.parse(height));
      store.user = user;
      showAppDialog(
          title: "Sign up",
          button: "OK",
          content: "Sign up successfully !",
          dismissOnTap: false,
          onPressed: () {
            Get.offNamed(AppRoutes.SignUp);
          });
    } else {
      showAppDialog(title: "Sign up", button: "OK", content: validateStr);
    }
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

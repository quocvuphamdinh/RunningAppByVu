import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/constant/constant.dart';
import 'package:running_app_flutter/data/models/user.dart';
import 'package:running_app_flutter/data/repositories/impl/user_repository_impl.dart';
import 'package:running_app_flutter/data/repositories/user_repository.dart';
import 'package:running_app_flutter/extensions/email_validator_extension.dart';
import 'package:running_app_flutter/models/data_state.dart';
import 'package:running_app_flutter/routes/app_routes.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController(Get.find<UserRepositoryImpl>()));
  }
}

class SignUpController extends BaseController {
  final UserRepository _userRepo;
  SignUpController(this._userRepo);

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

  register() async {
    showLoading(messaging: "Sign up...");
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
      var userExists =
          await _userRepo.checkEmailAccount(username: user.userName);
      if (userExists is DataSuccess) {
        if (userExists.data!.userName.isNotEmpty) {
          dismissLoading();
          showAppDialog(
              title: Constant.TITLE_ALERT,
              button: "OK",
              content: "This email account has already used !");
          return;
        }
        var sendEmail = await _userRepo.sendOTPToEmail(email: user.userName);
        if (sendEmail is DataSuccess) {
          dismissLoading();
          var otpSuccess = await Get.toNamed(AppRoutes.Verification,
              arguments: {"email_verification": user.userName}) as bool;
          if (otpSuccess) {
            showLoading(messaging: "Sign up...");
            var register = await _userRepo.register(user: user);
            if (register is DataSuccess) {
              dismissLoading();
              showAppDialog(
                  title: Constant.TITLE_ALERT,
                  button: "OK",
                  content: "Sign up successfully !",
                  onPressed: () {
                    Get.back();
                  });
              return;
            }
            dismissLoading();
            var errorRegister = register.error!;
            showAppDialog(
                title: errorRegister.errorTitle,
                button: "OK",
                content: errorRegister.errorMsg);
          }
          dismissLoading();
          return;
        }
        dismissLoading();
        showAppDialog(
            title: sendEmail.error!.errorTitle,
            button: "OK",
            content: sendEmail.error!.errorMsg);
        return;
      }
      dismissLoading();
      showAppDialog(
          title: userExists.error!.errorTitle,
          button: "OK",
          content: userExists.error!.errorMsg);
      return;
    }
    dismissLoading();
    showAppDialog(
        title: Constant.TITLE_ALERT, button: "OK", content: validateStr);
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/constant/constant.dart';
import 'package:running_app_flutter/data/repositories/impl/run_repository_impl.dart';
import 'package:running_app_flutter/data/repositories/impl/user_repository_impl.dart';
import 'package:running_app_flutter/data/repositories/run_repository.dart';
import 'package:running_app_flutter/data/repositories/user_repository.dart';
import 'package:running_app_flutter/models/data_state.dart';
import 'package:running_app_flutter/routes/app_routes.dart';
import 'package:running_app_flutter/services/local_storage.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(
        Get.find<UserRepositoryImpl>(), Get.find<RunRepositoryImpl>()));
  }
}

class LoginController extends BaseController {
  final UserRepository _userRepo;
  final RunRepository _runRepo;
  LoginController(this._userRepo, this._runRepo);

  final store = Get.find<LocalStorageService>();

  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void onInit() {
    super.onInit();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  login() async {
    showLoading(messaging: "Login...");
    var email = emailController.text.trim();
    var password = passwordController.text.trim();
    var userLogin = await _userRepo.login(username: email, password: password);
    if (userLogin is DataSuccess) {
      var userResult = userLogin.data!;
      var isLoginSuccess = userResult.userName.isNotEmpty;
      if (isLoginSuccess) {
        store.user = userResult;
        store.isLogin = true;
        dismissLoading();
        showLoading(messaging: "Sync data...");
        var syncData =
            await _runRepo.getRunsFromNetwork(userId: userResult.id!);
        if (syncData is DataSuccess) {
          var runs = syncData.data!;
          await _runRepo.insertRuns(runs: runs);
          dismissLoading();
        } else {
          dismissLoading();
          showSnackBar(syncData.error!.errorTitle, syncData.error!.errorMsg);
        }
        Get.offAllNamed(AppRoutes.Run_Main);
        return;
      }
      dismissLoading();
      showAppDialog(
          title: Constant.TITLE_ALERT,
          button: "OK",
          content: "Username or password is not correct !");
      return;
    }
    dismissLoading();
    showAppDialog(
        title: userLogin.error!.errorTitle,
        button: "OK",
        content: userLogin.error!.errorMsg);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

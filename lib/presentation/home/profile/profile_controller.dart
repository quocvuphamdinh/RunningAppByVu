import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/constant/constant.dart';
import 'package:running_app_flutter/models/user.dart';
import 'package:running_app_flutter/routes/app_routes.dart';
import 'package:running_app_flutter/services/local_storage.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}

class ProfileController extends BaseController {
  final store = Get.find<LocalStorageService>();
  Rx<User?> user = (null as User?).obs;

  @override
  void onInit() {
    super.onInit();

    user.value = store.user;
  }

  goToEditProfile() async {
    if (user.value != null) {
      var result =
          await Get.toNamed(AppRoutes.EditProfile) as Map<String, bool>?;
      if (result != null) {
        var isEditProfile = result[Constant.EDIT_PROFILE_SUCCESS];
        if (isEditProfile != null && isEditProfile) {
          user.value = store.user;
        }
      }
    }
  }

  logout() {
    showAppDialog(
        title: "Logout ?",
        button: "Yes",
        content: "Do you want to logout this account ?",
        onPressed: () async {
          showLoading(messaging: "Logout...");

          await Future.delayed(const Duration(seconds: 2));
          store.isLogin = null;

          dismissLoading();
          Get.offAllNamed(AppRoutes.Welcome);
        });
  }
}

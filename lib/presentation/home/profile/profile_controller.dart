import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/constant/constant.dart';
import 'package:running_app_flutter/data/models/user.dart';
import 'package:running_app_flutter/data/repositories/impl/run_repository_impl.dart';
import 'package:running_app_flutter/data/repositories/impl/user_repository_impl.dart';
import 'package:running_app_flutter/data/repositories/run_repository.dart';
import 'package:running_app_flutter/data/repositories/user_repository.dart';
import 'package:running_app_flutter/models/data_state.dart';
import 'package:running_app_flutter/routes/app_routes.dart';
import 'package:running_app_flutter/services/local_storage.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController(
        Get.find<RunRepositoryImpl>(), Get.find<UserRepositoryImpl>()));
  }
}

class ProfileController extends BaseController {
  final RunRepository _runRepo;
  final UserRepository _userRepo;
  ProfileController(this._runRepo, this._userRepo);

  final refreshController = RefreshController(initialRefresh: false);

  final store = Get.find<LocalStorageService>();
  Rx<User?> user = (null as User?).obs;
  RxInt totalDistance = 0.obs;
  RxInt totalDuration = 0.obs;
  RxInt totalCalories = 0.obs;
  RxDouble avgSpeed = 0.0.obs;

  @override
  void onInit() {
    super.onInit();

    onInitUser();
    onInitMyProgress();
  }

  onRefresh() {
    onInitUser();
    onInitMyProgress();
    refreshController.refreshCompleted();
  }

  onInitMyProgress() async {
    totalDistance.value = await _runRepo.getTotalDistance();
    totalDuration.value = await _runRepo.getTotalTimeInMillies();
    totalCalories.value = await _runRepo.getTotalCaloriesBurned();
    avgSpeed.value = await _runRepo.getTotalAvgSpeedInKMH();
  }

  onInitUser() {
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

  syncData() async {
    var syncUser = await _userRepo.updateUser(user: store.user!);
    if (syncUser is DataFailed) {
      dismissLoading();
      showSnackBar(syncUser.error!.errorTitle, syncUser.error!.errorMsg);
      return;
    }
    var runs = await _runRepo.getAllRun();
    for (var run in runs) {
      var sync =
          await _runRepo.insertRunToNetwork(run: run, userId: user.value!.id!);
      if (sync is DataFailed) {
        dismissLoading();
        showSnackBar(sync.error!.errorTitle, sync.error!.errorMsg);
        return;
      }
    }
    showSnackBar(Constant.TITLE_ALERT, "Sync data completed !");
  }

  logout() async {
    showAppDialog(
        title: Constant.TITLE_ALERT,
        button: "Yes",
        content: "Do you want to logout this account ?",
        onPressed: () async {
          showLoading(messaging: "Logout...");

          var syncUser = await _userRepo.updateUser(user: store.user!);
          if (syncUser is DataFailed) {
            dismissLoading();
            showAppDialog(
                title: syncUser.error!.errorTitle,
                content: syncUser.error!.errorMsg,
                button: "OK");
            return;
          }
          var runs = await _runRepo.getAllRun();
          for (var run in runs) {
            var sync = await _runRepo.insertRunToNetwork(
                run: run, userId: user.value!.id!);
            if (sync is DataFailed) {
              dismissLoading();
              showAppDialog(
                  title: sync.error!.errorTitle,
                  content: sync.error!.errorMsg,
                  button: "OK");
              return;
            }
          }
          await _runRepo.deleteAllRun();
          store.user = null;
          store.isLogin = null;

          dismissLoading();
          Get.offAllNamed(AppRoutes.Welcome);
        });
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }
}

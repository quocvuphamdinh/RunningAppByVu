import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/constant/constant.dart';
import 'package:running_app_flutter/data/models/run.dart';
import 'package:running_app_flutter/data/repositories/impl/run_repository_impl.dart';
import 'package:running_app_flutter/models/data_state.dart';
import 'package:running_app_flutter/presentation/home/home_page/home_controller.dart';
import 'package:running_app_flutter/presentation/home/profile/run_history/run_history_controller.dart';
import 'package:running_app_flutter/services/firebase_storage.dart';

class RunHistoryDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RunHistoryDetailController(Get.find<RunRepositoryImpl>()),
        fenix: true);
  }
}

class RunHistoryDetailController extends BaseController {
  final RunRepositoryImpl _runRepo;
  RunHistoryDetailController(this._runRepo);
  final firebaseService = Get.find<FirebaseStorageService>();

  Rx<Run?> run = (null as Run?).obs;
  @override
  void onInit() {
    super.onInit();

    initRun();
  }

  deleterun() async {
    final data = await _runRepo.deleteRunRemote(run: run.value!);
    if (data is DataFailed) {
      if (isShowLoading()) {
        dismissLoading();
      }
      showAppDialog(
          title: Constant.TITLE_ALERT,
          button: "OK",
          content: data.error!.errorMsg);
      return;
    }
    await _runRepo.deleteRun(id: run.value!.id);
    if (isShowLoading()) {
      dismissLoading();
    }
    Get.find<RunHistoryController>().initRuns();
    if (run.value!.isRunWithExercise == Constant.RUN_WITH_EXERCISE) {
      Get.find<HomeController>().onInitRecentActivityList();
    }
    Get.delete<RunHistoryDetailController>();
    Get.back();
  }

  onDeleteRun() {
    showAppDialog(
        title: Constant.TITLE_ALERT,
        content:
            "Are you sure to delete this run and the exercise related to it will be deleted too ?",
        button: "Yes",
        onPressed: () async {
          showLoading(messaging: "Deleting...");
          if (run.value!.img != null && run.value!.img!.isNotEmpty) {
            firebaseService.deleteImage("run${run.value!.id}", () async {
              await deleterun();
            }, (message) async {
              await deleterun();
              if (isShowLoading()) {
                dismissLoading();
              }
            });
          } else {
            await deleterun();
          }
        });
  }

  initRun() async {
    var id = Get.arguments['run_id'] as String?;
    if (id != null) {
      run.value = await _runRepo.getRunById(id: id);
    }
  }
}

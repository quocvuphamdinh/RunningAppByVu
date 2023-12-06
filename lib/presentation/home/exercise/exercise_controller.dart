import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/constant/constant.dart';
import 'package:running_app_flutter/data/models/activity.dart';
import 'package:running_app_flutter/data/models/workout.dart';
import 'package:running_app_flutter/data/repositories/exercise_repository.dart';
import 'package:running_app_flutter/data/repositories/impl/exercise_repository_impl.dart';
import 'package:running_app_flutter/models/data_state.dart';
import 'package:running_app_flutter/services/local_storage.dart';

class ExerciseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExerciseController(Get.find<ExerciseRepositoryImpl>()));
  }
}

class ExerciseController extends BaseController {
  final ExerciseRepository _exerciseRepo;
  ExerciseController(this._exerciseRepo);

  final store = Get.find<LocalStorageService>();
  final refreshController = RefreshController(initialRefresh: false);
  RxList walkingExercises = [].obs;
  RxList runningExercises = [].obs;
  RxBool isLoadingWalkingExercises = false.obs;
  RxBool isLoadingRunningExercises = false.obs;

  @override
  void onInit() {
    super.onInit();

    onInitWalkingExercises();
    onInitRunningExercises();
  }

  onInitWalkingExercises() async {
    walkingExercises.value = [];
    isLoadingWalkingExercises.value = true;
    final data = await _exerciseRepo.getListExerciseByType(
        type: Constant.WALKING, userId: store.user!.id!, size: 4);
    if (data is DataSuccess) {
      walkingExercises.value = data.data!;
      isLoadingWalkingExercises.value = false;
      return;
    }
    print("Get Walking exercises error: ${data.error!.errorMsg}");
    isLoadingWalkingExercises.value = false;
  }

  onInitRunningExercises() async {
    runningExercises.value = [];
    isLoadingRunningExercises.value = true;
    final data = await _exerciseRepo.getListExerciseByType(
        type: Constant.RUNNING, userId: store.user!.id!, size: 4);
    if (data is DataSuccess) {
      runningExercises.value = data.data!;
      isLoadingRunningExercises.value = false;
      return;
    }
    print("Get Running exercises error: ${data.error!.errorMsg}");
    isLoadingRunningExercises.value = false;
  }

  onRefresh() async {
    onInitWalkingExercises();
    onInitRunningExercises();
    refreshController.refreshCompleted();
  }
}

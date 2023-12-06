import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/constant/constant.dart';
import 'package:running_app_flutter/data/models/activity.dart';
import 'package:running_app_flutter/data/repositories/exercise_repository.dart';
import 'package:running_app_flutter/data/repositories/impl/exercise_repository_impl.dart';
import 'package:running_app_flutter/models/data_state.dart';
import 'package:running_app_flutter/services/local_storage.dart';

class ExerciseListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
        () => ExerciseListController(Get.find<ExerciseRepositoryImpl>()),
        fenix: true);
  }
}

class ExerciseListController extends BaseController {
  final ExerciseRepository _exerciseRepo;
  ExerciseListController(this._exerciseRepo);

  final store = Get.find<LocalStorageService>();
  dynamic argumentData = Get.arguments;

  RxInt exerciseType = Constant.RUNNING.obs;
  RxString exerciseTitle = "Exercise List".obs;
  RxInt totalExerciseCompleted = 0.obs;
  RxInt totalExercise = 0.obs;
  RxList<Activity> exercises = <Activity>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    exerciseType.value =
        argumentData[Constant.EXERCISE_TYPE] ?? Constant.RUNNING;
    exerciseTitle.value =
        argumentData[Constant.EXERCISE_TITLE] ?? exerciseTitle.value;

    onInitExercises();
  }

  onInitExercises() async {
    isLoading.value = true;
    final data = await _exerciseRepo.getListExerciseByType(
        type: exerciseType.value, userId: store.user!.id!);
    if (data is DataSuccess) {
      exercises.value = data.data!;
      onInitDataTotal();
      isLoading.value = false;
      return;
    }
    print("Error get exercises: ${data.error!.errorMsg}");
    isLoading.value = false;
  }

  onInitDataTotal() {
    var totalCompleted = 0;
    for (var item in exercises) {
      if (item.isCompleted == 1) {
        totalCompleted += 1;
      }
    }
    totalExerciseCompleted.value = totalCompleted;
    totalExercise.value = exercises.length;
  }
}

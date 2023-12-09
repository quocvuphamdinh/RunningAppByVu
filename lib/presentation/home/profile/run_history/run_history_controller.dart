import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/constant/constant.dart';
import 'package:running_app_flutter/constant/data_run_types.dart';
import 'package:running_app_flutter/data/models/run.dart';
import 'package:running_app_flutter/data/repositories/impl/run_repository_impl.dart';
import 'package:running_app_flutter/data/repositories/run_repository.dart';

class RunHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RunHistoryController(Get.find<RunRepositoryImpl>()));
  }
}

class RunHistoryController extends BaseController {
  final RunRepository _runRepo;
  RunHistoryController(this._runRepo);

  RxList<Run> runsOnly = <Run>[].obs;
  RxList<Run> runWithExercises = <Run>[].obs;
  @override
  void onInit() {
    super.onInit();

    initRuns();
  }

  initRuns() async {
    final runs =
        await _runRepo.getAllByType(type: Constant.RUN_NOT_WITH_EXERCISE);
    runsOnly.value = runs;

    final runsWithExer =
        await _runRepo.getAllByType(type: Constant.RUN_WITH_EXERCISE);
    runWithExercises.value = runsWithExer;
  }

  onSortedRuns(SortType sortType) async {
    runsOnly.value = await _runRepo.getAllRunsSortedByType(
        isRunWithExercise: Constant.RUN_NOT_WITH_EXERCISE, sortType: sortType);
  }

  onSortedRunsWithExercise(SortType sortType) async {
    runWithExercises.value = await _runRepo.getAllRunsSortedByType(
        isRunWithExercise: Constant.RUN_WITH_EXERCISE, sortType: sortType);
  }
}

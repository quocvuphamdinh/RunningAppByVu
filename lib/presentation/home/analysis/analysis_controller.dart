import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/constant/data_run_types.dart';
import 'package:running_app_flutter/data/repositories/impl/run_repository_impl.dart';
import 'package:running_app_flutter/data/repositories/run_repository.dart';
import 'package:running_app_flutter/presentation/home/analysis/models/analysis_bar_model.dart';

class AnalysisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AnalysisController(Get.find<RunRepositoryImpl>()));
  }
}

class AnalysisController extends BaseController {
  final RunRepository _runRepo;
  AnalysisController(this._runRepo);

  RxList<AnalysisBarModel> analysisDistanceDay = <AnalysisBarModel>[].obs;
  RxList<AnalysisBarModel> analysisDurationDay = <AnalysisBarModel>[].obs;
  RxList<AnalysisBarModel> analysisCaloriesDay = <AnalysisBarModel>[].obs;
  RxList<AnalysisBarModel> analysisAvgSpeedDay = <AnalysisBarModel>[].obs;

  RxList<AnalysisBarModel> analysisDistanceMonth = <AnalysisBarModel>[].obs;
  RxList<AnalysisBarModel> analysisDurationMonth = <AnalysisBarModel>[].obs;
  RxList<AnalysisBarModel> analysisCaloriesMonth = <AnalysisBarModel>[].obs;
  RxList<AnalysisBarModel> analysisAvgSpeedMonth = <AnalysisBarModel>[].obs;

  List<AnalysisBarModel> analysisDayBars = [
    AnalysisBarModel(id: 1, name: "Mon", y: 50),
    AnalysisBarModel(id: 2, name: "Tue", y: 60),
    AnalysisBarModel(id: 3, name: "Wed", y: 70),
    AnalysisBarModel(id: 4, name: "Thu", y: 80),
    AnalysisBarModel(id: 5, name: "Fri", y: 80),
    AnalysisBarModel(id: 6, name: "Sat", y: 80),
    AnalysisBarModel(id: 7, name: "Sun", y: 80)
  ];
  List<AnalysisBarModel> analysisMonthBars = [
    AnalysisBarModel(id: 1, name: "1", y: 50),
    AnalysisBarModel(id: 2, name: "2", y: 60),
    AnalysisBarModel(id: 3, name: "3", y: 70),
    AnalysisBarModel(id: 4, name: "4", y: 80),
    AnalysisBarModel(id: 5, name: "5", y: 80),
    AnalysisBarModel(id: 6, name: "6", y: 20),
    AnalysisBarModel(id: 7, name: "7", y: 10),
    AnalysisBarModel(id: 8, name: "8", y: 10),
    AnalysisBarModel(id: 9, name: "9", y: 10),
    AnalysisBarModel(id: 10, name: "10", y: 10),
    AnalysisBarModel(id: 11, name: "11", y: 5),
    AnalysisBarModel(id: 12, name: "12", y: 1)
  ];

  @override
  void onInit() {
    super.onInit();
  }

  onSelectedCalories(int date, DataAnalysisTypes type) async {
    if (type == DataAnalysisTypes.DAY) {
      analysisCaloriesDay.value = await _runRepo.getTotalRunDataInEachDay(
          date, DataRunTypes.CALORIESBURNED);
      return;
    }
    analysisCaloriesMonth.value = await _runRepo.getTotalRunDataInEachMonth(
        date, DataRunTypes.CALORIESBURNED);
  }

  onSelectedDuration(int date, DataAnalysisTypes type) async {
    if (type == DataAnalysisTypes.DAY) {
      analysisDurationDay.value =
          await _runRepo.getTotalRunDataInEachDay(date, DataRunTypes.DURATION);
      return;
    }
    analysisDurationMonth.value =
        await _runRepo.getTotalRunDataInEachMonth(date, DataRunTypes.DURATION);
  }

  onSelectedDistance(int date, DataAnalysisTypes type) async {
    if (type == DataAnalysisTypes.DAY) {
      analysisDistanceDay.value =
          await _runRepo.getTotalRunDataInEachDay(date, DataRunTypes.DISTANCE);
      return;
    }
    analysisDistanceMonth.value =
        await _runRepo.getTotalRunDataInEachMonth(date, DataRunTypes.DISTANCE);
  }

  onSelectedAvgSpeed(int date, DataAnalysisTypes type) async {
    if (type == DataAnalysisTypes.DAY) {
      analysisAvgSpeedDay.value =
          await _runRepo.getTotalRunDataInEachDay(date, DataRunTypes.AVGSPEED);
      return;
    }
    analysisAvgSpeedMonth.value =
        await _runRepo.getTotalRunDataInEachMonth(date, DataRunTypes.AVGSPEED);
  }
}

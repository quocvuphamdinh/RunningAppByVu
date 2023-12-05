import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/data/repositories/impl/run_repository_impl.dart';
import 'package:running_app_flutter/presentation/home/analysis/analysis_controller.dart';
import 'package:running_app_flutter/presentation/home/exercise/exercise_controller.dart';
import 'package:running_app_flutter/presentation/home/home_page/home_controller.dart';
import 'package:running_app_flutter/presentation/home/profile/profile_controller.dart';

class RunMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RunMainController());

    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ExerciseController());
    Get.lazyPut(() => AnalysisController());
    Get.lazyPut(() => ProfileController(Get.find<RunRepositoryImpl>()));
  }
}

class RunMainController extends BaseController {
  static const HOME_INDEX = 0;
  static const EXERCISE_INDEX = 1;
  static const ANALYSIS_INDEX = 2;
  static const PROFILE_INDEX = 3;

  Rx<int> selectedPage = 0.obs;
  @override
  void onInit() {
    super.onInit();

    if (isShowLoading()) {
      dismissLoading();
    }
  }

  onSelectedPage(int index) {
    selectedPage.value = index;
  }
}

import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/data/repositories/impl/exercise_repository_impl.dart';
import 'package:running_app_flutter/data/repositories/impl/run_repository_impl.dart';
import 'package:running_app_flutter/data/repositories/impl/user_exercise_repository_impl.dart';
import 'package:running_app_flutter/data/repositories/impl/user_repository_impl.dart';
import 'package:running_app_flutter/presentation/home/analysis/analysis_controller.dart';
import 'package:running_app_flutter/presentation/home/exercise/exercise_controller.dart';
import 'package:running_app_flutter/presentation/home/home_page/home_controller.dart';
import 'package:running_app_flutter/presentation/home/profile/profile_controller.dart';

class RunMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RunMainController());

    Get.lazyPut(() => HomeController(
        Get.find<RunRepositoryImpl>(),
        Get.find<ExerciseRepositoryImpl>(),
        Get.find<UserExerciseRepositoryImpl>()));
    Get.lazyPut(() => ExerciseController(Get.find<ExerciseRepositoryImpl>()));
    Get.lazyPut(() => AnalysisController(Get.find<RunRepositoryImpl>()));
    Get.lazyPut(() => ProfileController(
        Get.find<RunRepositoryImpl>(),
        Get.find<UserRepositoryImpl>(),
        Get.find<UserExerciseRepositoryImpl>()));
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

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/constant/constant.dart';
import 'package:running_app_flutter/data/models/activity.dart';
import 'package:running_app_flutter/data/models/user.dart';
import 'package:running_app_flutter/data/models/user_activity_detail.dart';
import 'package:running_app_flutter/data/repositories/exercise_repository.dart';
import 'package:running_app_flutter/data/repositories/impl/exercise_repository_impl.dart';
import 'package:running_app_flutter/data/repositories/impl/run_repository_impl.dart';
import 'package:running_app_flutter/data/repositories/impl/user_exercise_repository_impl.dart';
import 'package:running_app_flutter/data/repositories/run_repository.dart';
import 'package:running_app_flutter/data/repositories/user_exercise_repository.dart';
import 'package:running_app_flutter/models/data_state.dart';
import 'package:running_app_flutter/routes/app_routes.dart';
import 'package:running_app_flutter/services/local_storage.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(
        Get.find<RunRepositoryImpl>(),
        Get.find<ExerciseRepositoryImpl>(),
        Get.find<UserExerciseRepositoryImpl>()));
  }
}

class HomeController extends BaseController {
  final RunRepository _runRepo;
  final ExerciseRepository _exerciseRepo;
  final UserExerciseRepository _userExerRepo;
  HomeController(this._runRepo, this._exerciseRepo, this._userExerRepo);

  final store = Get.find<LocalStorageService>();
  final refreshController = RefreshController(initialRefresh: false);

  Rx<User?> user = (null as User?).obs;
  RxInt totalDistanceWeekly = 0.obs;
  RxInt totalCalories = 0.obs;
  RxInt totalRunMillies = 0.obs;
  RxDouble totalAvgSpeed = 0.0.obs;
  RxInt totalRun = 0.obs;
  RxInt longestDistance = 0.obs;
  RxInt longestDuration = 0.obs;
  RxInt bestCalories = 0.obs;

  RxList<Activity> todayTraninings = <Activity>[].obs;

  RxList<UserActivityDetail> recentActivites = <UserActivityDetail>[].obs;

  RxBool isLoadingTodayTraining = false.obs;
  RxBool isLoadingRecentExercise = false.obs;
  @override
  void onInit() {
    super.onInit();

    onInitUser();
    onInitTotalDistanceWeekly();
    onInitProgressToday();
    onInitTodayTraniningList();
    onInitRecentActivityList();
    onInitBestRecords();
    refreshController.refreshCompleted();
  }

  goToSetMyGoal() async {
    final weeklyGoal = await Get.toNamed(AppRoutes.WeeklyGoalSetting,
            arguments: {Constant.INTENT_SET_MYGOAL: user.value!.distanceGoal})
        as int?;
    if (weeklyGoal != null) {
      user.value!.distanceGoal = weeklyGoal;
      store.user = user.value!;
      user.refresh();
    }
  }

  onInitRecentActivityList() async {
    recentActivites.value = [];
    isLoadingRecentExercise.value = true;
    final data = await _userExerRepo.getListUserExercise(
        userId: user.value!.id!, page: 2);
    if (data is DataSuccess) {
      recentActivites.value = data.data!;
      isLoadingRecentExercise.value = false;
      return;
    }
    print("Error recent exercise: ${data.error!.errorMsg}");
    isLoadingRecentExercise.value = false;
  }

  onInitTodayTraniningList() async {
    todayTraninings.value = [];
    isLoadingTodayTraining.value = true;
    final data = await _exerciseRepo.getListExerciseByType(
        type: Constant.RUNNING, userId: user.value!.id!, size: 4);
    if (data is DataSuccess) {
      todayTraninings.value = data.data!;
      isLoadingTodayTraining.value = false;
      return;
    }
    print("Error today trainings: ${data.error!.errorMsg}");
    isLoadingTodayTraining.value = false;
  }

  onInitBestRecords() async {
    longestDistance.value = await _runRepo.getMaxDistance();
    longestDuration.value = await _runRepo.getMaxTimeInMillies();
    bestCalories.value = await _runRepo.getMaxCaloriesBurned();
  }

  onInitTotalDistanceWeekly() async {
    totalDistanceWeekly.value = await _runRepo.getTotalDitanceWeekly();
  }

  onInitProgressToday() async {
    totalCalories.value = await _runRepo.getTotalCaloriesBurnedToDay();
    totalRunMillies.value = await _runRepo.getTotalTimeInMillisToday();
    totalAvgSpeed.value = await _runRepo.getTotalAvgSpeedInKMHToday();
    totalRun.value = await _runRepo.getCountRunToday();
  }

  onInitUser() {
    user.value = store.user;
  }

  onRefresh() {
    onInitUser();
    onInitTotalDistanceWeekly();
    onInitProgressToday();
    onInitBestRecords();
    onInitTodayTraniningList();
    onInitRecentActivityList();
    refreshController.refreshCompleted();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }
}

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/data/models/user_activity_detail.dart';
import 'package:running_app_flutter/data/repositories/impl/user_exercise_repository_impl.dart';
import 'package:running_app_flutter/data/repositories/user_exercise_repository.dart';
import 'package:running_app_flutter/models/data_state.dart';
import 'package:running_app_flutter/services/local_storage.dart';

class RecentExerciseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
        () => RecentExerciseController(Get.find<UserExerciseRepositoryImpl>()),
        fenix: true);
  }
}

class RecentExerciseController extends BaseController {
  final UserExerciseRepository _userExerRepo;
  RecentExerciseController(this._userExerRepo);

  final store = Get.find<LocalStorageService>();

  final refreshController = RefreshController(initialRefresh: false);

  RxList<UserActivityDetail> recentActivites = <UserActivityDetail>[].obs;

  RxDouble totalKm = 0.0.obs;
  RxInt totalDuration = 0.obs;
  RxInt totalCalories = 0.obs;
  RxDouble totalAvgSpeed = 0.0.obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    onInitTotalData();
    onInitList();
  }

  onRefresh() {
    onInitTotalData();
    onInitList();
    refreshController.refreshCompleted();
  }

  onInitTotalData() async {
    final data = await _userExerRepo.calculateDataRecentActivity(
        userId: store.user!.id!);
    if (data is DataSuccess) {
      totalKm.value = (int.parse(data.data!['distance'] as String)) / 1000;
      totalDuration.value = int.parse(data.data!['duration'] as String);
      totalCalories.value = int.parse(data.data!['caloriesBurned'] as String);
      totalAvgSpeed.value = double.parse(data.data!['avgSpeed'] as String);
      return;
    }
    print("Error calculate exercise: ${data.error!.errorMsg}");
  }

  onInitList() async {
    recentActivites.value = [];
    isLoading.value = true;
    final data =
        await _userExerRepo.getListUserExercise(userId: store.user!.id!);
    if (data is DataSuccess) {
      recentActivites.value = data.data!;
      isLoading.value = false;
      return;
    }
    print("Error recent exercise: ${data.error!.errorMsg}");
    isLoading.value = false;
  }
}

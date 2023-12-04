import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/data/models/run.dart';
import 'package:running_app_flutter/data/repositories/impl/run_repository_impl.dart';

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

  Rx<Run?> run = (null as Run?).obs;
  @override
  void onInit() {
    super.onInit();

    initRun();
  }

  initRun() async {
    var id = Get.arguments['run_id'] as String?;
    if (id != null) {
      run.value = await _runRepo.getRunById(id: id);
    }
  }
}

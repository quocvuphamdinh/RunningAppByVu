import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:running_app_flutter/base/base_controller.dart';

class ExecuteRunBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExecuteRunController());
  }
}

class ExecuteRunController extends BaseController {
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

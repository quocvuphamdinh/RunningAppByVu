import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:running_app_flutter/base/base_controller.dart';

class VerificationBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => VerificationController());
  }
}

class VerificationController extends BaseController {
  late OtpFieldController otpController;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    otpController = OtpFieldController();
  }
}

import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/data/repositories/impl/user_repository_impl.dart';
import 'package:running_app_flutter/data/repositories/user_repository.dart';
import 'package:running_app_flutter/models/data_state.dart';

class VerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerificationController(Get.find<UserRepositoryImpl>()),
        fenix: true);
  }
}

class VerificationController extends BaseController {
  final UserRepository _userRepo;
  VerificationController(this._userRepo);

  late OtpFieldController otpController;
  RxString email = "".obs;
  RxBool isSendAgain = false.obs;
  @override
  void onInit() {
    super.onInit();

    email.value = Get.arguments['email_verification'] as String;
    otpController = OtpFieldController();
  }

  onSendOTPAgain() async {
    isSendAgain.value = true;
    var sendOTP = await _userRepo.sendOTPToEmail(email: email.value);
    if (sendOTP is DataSuccess) {
      var message = sendOTP.data!["message"];
      showSnackBar("Send OTP", message!);
      isSendAgain.value = false;
      return;
    }
    var error = sendOTP.error!;
    showSnackBar(error.errorTitle, error.errorMsg);
    isSendAgain.value = false;
  }

  onCheckOTP(String otpCode) async {
    showLoading(messaging: "Processing...");
    var checkOTP = await _userRepo.checkOTP(otpCode: otpCode);
    dismissLoading();
    if (checkOTP is DataSuccess) {
      var success = checkOTP.data!;
      if (success) {
        Get.back(result: true);
        return;
      }
      showSnackBar("OTP Verification", "OTP is not correct !!");
      return;
    }
    var error = checkOTP.error!;
    showSnackBar(error.errorTitle, error.errorMsg);
  }

  onBack() {
    Get.delete<VerificationController>();
    Get.back(result: false);
  }
}

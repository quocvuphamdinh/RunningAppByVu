import 'package:get/get.dart';
import 'package:running_app_flutter/constant/error_code.dart';
import 'package:running_app_flutter/data/models/app_error.dart';
import 'package:running_app_flutter/data/models/user.dart';
import 'package:running_app_flutter/data/providers/network/api_service.dart';
import 'package:running_app_flutter/data/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final apiService = Get.find<ApiService>();
  @override
  Future<void> register({required User user}) {
    return apiService.register(user);
  }

  @override
  Future<dynamic> checkEmailExists({required String email}) async {
    var response = await apiService.checkEmailExists(email);
    var message = response['message'] ?? "";
    if (message.contains("Failed")) {
      return AppError(
          errorCode: ErrorCode.DEFAULT, errorTitle: "Error", errorMsg: message);
    }
    return message;
  }
}

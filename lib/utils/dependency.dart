import 'package:get/get.dart';
import 'package:running_app_flutter/data/repositories/impl/exercise_repository_impl.dart';
import 'package:running_app_flutter/data/repositories/impl/run_repository_impl.dart';
import 'package:running_app_flutter/data/repositories/impl/user_exercise_repository_impl.dart';
import 'package:running_app_flutter/data/repositories/impl/user_repository_impl.dart';

class DependencyInjection {
  static init() {
    Get.put(RunRepositoryImpl(), permanent: true);
    Get.put(UserRepositoryImpl(), permanent: true);
    Get.put(ExerciseRepositoryImpl(), permanent: true);
    Get.put(UserExerciseRepositoryImpl(), permanent: true);
  }
}

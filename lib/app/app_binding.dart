import 'package:get/get.dart';
import 'package:running_app_flutter/presentation/play_music/play_music_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PlayMusicController(), permanent: true);
  }
}

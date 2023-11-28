import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/config/data/app_data.dart';
import 'package:running_app_flutter/models/music.dart';

class PlayMusicController extends BaseController {
  RxInt duration = 0.obs;
  RxInt progressValue = 0.obs;
  Rx<Music> musicCurrent = (AppData.musicList[0]).obs;
  RxBool isPlaying = false.obs;
  RxInt indexIsPlaying = (-1).obs;
  RxList<Music> listMusic = AppData.musicList.obs;

  late AssetsAudioPlayer assetsAudioPlayer;

  @override
  void onInit() {
    super.onInit();

    initAudioPlayer();
  }

  initAudioPlayer() {
    assetsAudioPlayer = AssetsAudioPlayer();
    assetsAudioPlayer.open(
        autoStart: false,
        Playlist(audios: listMusic.map((e) => Audio(e.file)).toList()),
        loopMode: LoopMode.playlist);

    assetsAudioPlayer.current.listen((playingAudio) {
      if (playingAudio != null) {
        musicCurrent.value = listMusic[playingAudio.index];
        duration.value = playingAudio.audio.duration.inMilliseconds;
        indexIsPlaying.value = playingAudio.index;
        onChangeIsPlayingInList();
      }
    });

    assetsAudioPlayer.currentPosition.listen((event) {
      progressValue.value = event.inMilliseconds;
    });

    assetsAudioPlayer.playlistAudioFinished.listen((Playing playing) {
      musicCurrent.value = listMusic[playing.index];
      onChangeIsPlayingInList();
    });
  }

  onChangeIsPlayingInList() {
    for (int i = 0; i < listMusic.length; i++) {
      if (i == indexIsPlaying.value) {
        listMusic[i].isPlaying = true;
      } else {
        listMusic[i].isPlaying = false;
      }
    }
    listMusic.refresh();
  }

  onClickNext() {
    assetsAudioPlayer.next();
    isPlaying.value = true;
  }

  onClickPre() {
    assetsAudioPlayer.previous();
    isPlaying.value = true;
  }

  onClickPlay() {
    if (assetsAudioPlayer.isPlaying.value) {
      assetsAudioPlayer.pause();
      isPlaying.value = false;
    } else {
      assetsAudioPlayer.play();
      isPlaying.value = true;
    }
  }

  onClickPlayAtIndex(int index) {
    assetsAudioPlayer.playlistPlayAtIndex(index);
    isPlaying.value = true;
  }

  onProgressChanged(int value) {
    progressValue.value = value;
    assetsAudioPlayer.seek(Duration(milliseconds: value));
  }

  onStopAudioPlayer() {
    assetsAudioPlayer.stop();
    isPlaying.value = false;
    indexIsPlaying.value = -1;
  }
}

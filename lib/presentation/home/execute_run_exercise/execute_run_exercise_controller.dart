import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/constant/constant.dart';
import 'package:running_app_flutter/data/models/activity.dart';
import 'package:running_app_flutter/data/models/run.dart';
import 'package:running_app_flutter/data/models/user_activity.dart';
import 'package:running_app_flutter/data/models/workout.dart';
import 'package:running_app_flutter/data/repositories/impl/run_repository_impl.dart';
import 'package:running_app_flutter/data/repositories/impl/user_exercise_repository_impl.dart';
import 'package:running_app_flutter/data/repositories/run_repository.dart';
import 'package:running_app_flutter/data/repositories/user_exercise_repository.dart';
import 'package:running_app_flutter/models/data_state.dart';
import 'package:running_app_flutter/presentation/play_music/play_music_controller.dart';
import 'package:running_app_flutter/services/firebase_storage.dart';
import 'package:running_app_flutter/services/local_storage.dart';
import 'package:running_app_flutter/utils/map_utils.dart';

class ExecuteRunExerciseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExecuteRunExerciseController(
        Get.find<RunRepositoryImpl>(), Get.find<UserExerciseRepositoryImpl>()));
  }
}

class ExecuteRunExerciseController extends BaseController {
  final RunRepository _runRepo;
  final UserExerciseRepository _userExerciseRepo;
  ExecuteRunExerciseController(this._runRepo, this._userExerciseRepo);

  final store = Get.find<LocalStorageService>();
  final firebaseStorage = Get.find<FirebaseStorageService>();
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  StreamSubscription? _locationSubscription;

  Rx<Marker?> marker = (null as Marker?).obs;
  final RxSet<Polyline> polyline = <Polyline>{}.obs;
  List<LatLng> latlngs = [];
  late LocationSettings locationSettings;
  Rx<Duration> runDuration = const Duration().obs;
  Timer? timer = null;

  RxBool isRunning = false.obs;
  RxBool isToggleRun = false.obs;

  bool isGoogleMapDisposed = false;

  RxList<Workout> workouts = <Workout>[].obs;
  Activity? exercise;
  RxInt timeLeft = 0.obs;
  RxInt currentWorkoutIndex = 0.obs;

  RxInt distance = 0.obs;
  RxDouble avgSpeed = 0.0.obs;
  RxInt caloriesBurned = 0.obs;

  int totalWorkoutsDuration = 0;

  List<Workout> workoutsDone = [];

  @override
  void onInit() {
    super.onInit();

    exercise = Get.arguments['exercise'];
    workouts = exercise!.workouts.obs;
    workouts.refresh();
    int total = 0;
    for (var workout in workouts) {
      total += workout.duration;
    }
    totalWorkoutsDuration = total;
    timeLeft.value = total;

    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
          forceLocationManager: true,
          intervalDuration: const Duration(milliseconds: 200),
          foregroundNotificationConfig: const ForegroundNotificationConfig(
            notificationIcon: AndroidResource(name: "runner"),
            notificationText: "You are running with exercise",
            notificationTitle: "Running App By Vu",
            enableWakeLock: true,
          ));
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: 100,
        pauseLocationUpdatesAutomatically: true,
        showBackgroundLocationIndicator: false,
      );
    } else {
      locationSettings = const LocationSettings(
          accuracy: LocationAccuracy.high, distanceFilter: 100);
    }
  }

  saveRun() async {
    // distanceInMeters / 1000f : chia để lấy km
    //currentTimeInMillies / 1000f : lấy second
    // currentTimeInMillies / 1000f / 60 : lấy minute
    // currentTimeInMillies / 1000f / 60 / 60 : lấy hour
    // vận tốc bằng quãng đường chia cho thời gian
    stopRun();
    showLoading(messaging: "Saving...");
    var controller = await mapController.future;
    var firstLatLng = latlngs.first;
    var lastLatLng = latlngs.last;
    await controller.moveCamera(
      CameraUpdate.newLatLngBounds(
        MapUtils.boundsFromLatLngList(latlngs),
        10.0,
      ),
    );
    var currentTimeInMillies = runDuration.value.inMilliseconds;
    var distanceInMeters = Geolocator.distanceBetween(firstLatLng.latitude,
            firstLatLng.longitude, lastLatLng.latitude, lastLatLng.longitude)
        .round();
    var avgSpeed = ((distanceInMeters / 1000) /
                (currentTimeInMillies / 1000 / 60 / 60) *
                10)
            .round() /
        10;
    var user = store.user;
    var id = "${user!.userName}${DateTime.now().millisecondsSinceEpoch}";
    var dateTimestamp = DateTime.now().millisecondsSinceEpoch;
    var caloriesBurned = ((distanceInMeters / 1000) * user.weight).toInt();
    var run = Run(
        id: id,
        timestamp: dateTimestamp,
        averageSpeedInKilometersPerHour: avgSpeed,
        distanceInKilometers: distanceInMeters,
        timeInMillis: currentTimeInMillies,
        caloriesBurned: caloriesBurned,
        img: "",
        isRunWithExercise: 1);
    var userActivity = UserActivity(
        id: DateTime.now().millisecondsSinceEpoch,
        run: run,
        activityId: exercise!.id!,
        comment: "",
        mood: 0);
    await const Duration(seconds: 3).delay();
    var img = await controller.takeSnapshot();
    firebaseStorage.uploadImage("run$id", img!, (url) async {
      bool isInsertExerciseSuccess = false;
      bool isInsertRunSuccess = false;
      run.img = url;
      final dataRun =
          await _runRepo.insertRunToNetwork(run: run, userId: user.id!);
      if (dataRun is DataSuccess) {
        isInsertRunSuccess = true;
      }
      final data = await _userExerciseRepo.insertUserExerciseToNetwork(
          userActivity: userActivity, userId: user.id!);
      if (data is DataSuccess) {
        isInsertExerciseSuccess = true;
      }
      await _runRepo.insertRun(run: run);
      await _userExerciseRepo.insertUserExercise(userActivity: userActivity);

      if (isShowLoading()) {
        dismissLoading();
      }
      var message = "";
      if (!isInsertExerciseSuccess || !isInsertRunSuccess) {
        message =
            "Some thing went wrong. Your run data will be send to the server later !";
      } else {
        message = "Your run is finished !!";
      }
      showAppDialog(
          title: Constant.TITLE_ALERT,
          content: message,
          button: "OK",
          dismissOnTap: false,
          onPressed: () {
            onBack();
          });
    }, (message) async {
      bool isInsertExerciseSuccess = false;
      bool isInsertRunSuccess = false;
      final dataRun =
          await _runRepo.insertRunToNetwork(run: run, userId: user.id!);
      if (dataRun is DataSuccess) {
        isInsertRunSuccess = true;
      }
      final data = await _userExerciseRepo.insertUserExerciseToNetwork(
          userActivity: userActivity, userId: user.id!);
      if (data is DataSuccess) {
        isInsertExerciseSuccess = true;
      }
      await _runRepo.insertRun(run: run);
      await _userExerciseRepo.insertUserExercise(userActivity: userActivity);

      if (isShowLoading()) {
        dismissLoading();
      }
      var message = "";
      if (!isInsertExerciseSuccess || !isInsertRunSuccess) {
        message =
            "Some thing went wrong. Your run data will be send to the server later !";
      } else {
        message = "Your run is finished !!";
      }
      showAppDialog(
          title: Constant.TITLE_ALERT,
          content: message,
          button: "OK",
          dismissOnTap: false,
          onPressed: () {
            onBack();
          });
    });
  }

  addTime() async {
    const addMilliSecond = 10;
    final milliSeconds = runDuration.value.inMilliseconds + addMilliSecond;
    var totalDurationDone = 0;
    for (var done in workoutsDone) {
      totalDurationDone += done.duration;
    }
    if ((milliSeconds - totalDurationDone) ==
        workouts[currentWorkoutIndex.value].duration) {
      workoutsDone.add(workouts[currentWorkoutIndex.value]);
      if (currentWorkoutIndex.value < workouts.length - 1) {
        currentWorkoutIndex.value = currentWorkoutIndex.value + 1;
      }
    }
    if (milliSeconds == totalWorkoutsDuration) {
      await saveRun();
    }
    timeLeft.value = timeLeft.value - addMilliSecond;
    runDuration.value = Duration(milliseconds: milliSeconds);
  }

  startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      addTime();
    });
  }

  stopTimer() {
    timer?.cancel();
  }

  showExitRunningDialog({void Function()? onPressOK}) {
    showAppDialog(
        title: "Cancel the Run ?",
        content:
            "Are you sure to cancel this run and the data will be deleted ?",
        button: "OK",
        onPressed: onPressOK);
  }

  toggleRunning() {
    isRunning.value = !isRunning.value;
    isToggleRun.value = true;
  }

  Future<Uint8List> getMarker(BuildContext context) async {
    ByteData byteData = await DefaultAssetBundle.of(context)
        .load("assets/images/black_arrow.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndPolylines(Position newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    marker.value = Marker(
        markerId: const MarkerId("runner"),
        position: latlng,
        rotation: newLocalData.heading,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: const Offset(0.5, 0.5),
        icon: BitmapDescriptor.fromBytes(imageData, size: const Size(50, 50)));

    latlngs.add(latlng);

    polyline.add(Polyline(
      polylineId: PolylineId(newLocalData.toString()),
      visible: true,
      points: latlngs,
      color: AppColor.grey,
    ));
    polyline.refresh();
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  getCurrentLocation(BuildContext context) async {
    try {
      Uint8List imageData = await getMarker(context);
      if (!isToggleRun.value) {
        showLoading(messaging: "Processing...");
        var location = await determinePosition();

        updateMarkerAndPolylines(location, imageData);
      }
      toggleRunning();
      if (isRunning.value) {
        startTimer();
      } else {
        stopTimer();
      }

      var controller = await mapController.future;
      _locationSubscription ??=
          Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen((Position? position) {
        if (position != null && !isGoogleMapDisposed && isRunning.value) {
          controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  bearing: 192.8334901395799,
                  target: LatLng(position.latitude, position.longitude),
                  tilt: 0,
                  zoom: 18.00)));
          updateMarkerAndPolylines(position, imageData);

          calculateRunData();
        }
        if (isShowLoading()) {
          dismissLoading();
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  calculateRunData() {
    var firstLatLng = latlngs.first;
    var lastLatLng = latlngs.last;
    distance.value = Geolocator.distanceBetween(firstLatLng.latitude,
            firstLatLng.longitude, lastLatLng.latitude, lastLatLng.longitude)
        .round();
    avgSpeed.value = ((distance.value / 1000) /
                (runDuration.value.inMilliseconds / 1000 / 60 / 60) *
                10)
            .round() /
        10;
    caloriesBurned.value = ((distance.value / 1000) * 65).toInt();
  }

  stopRun() {
    isRunning.value = false;
    stopTimer();
  }

  onDisposeLocationSubscription() {
    if (_locationSubscription != null) {
      _locationSubscription!.cancel();
    }
  }

  onDisposeGoogleMapController() async {
    isGoogleMapDisposed = true;
    var controller = await mapController.future;
    controller.dispose();
  }

  @override
  void onClose() {
    polyline.clear();
    onDisposeLocationSubscription();
    onDisposeGoogleMapController();
    stopTimer();
    super.onClose();
  }

  onBack() {
    Get.find<PlayMusicController>().onStopAudioPlayer();
    Get.back();
  }

  @override
  Future<bool> onBackPress() async {
    if (isToggleRun.value) {
      showExitRunningDialog(onPressOK: onBack);
    } else {
      onBack();
    }
    return true;
  }
}

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/data/models/run.dart';
import 'package:running_app_flutter/data/repositories/impl/run_repository_impl.dart';
import 'package:running_app_flutter/data/repositories/run_repository.dart';
import 'package:running_app_flutter/presentation/play_music/play_music_controller.dart';
import 'package:running_app_flutter/services/firebase_storage.dart';
import 'package:running_app_flutter/services/local_storage.dart';
import 'package:running_app_flutter/utils/map_utils.dart';

class ExecuteRunBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExecuteRunController(Get.find<RunRepositoryImpl>()));
  }
}

class ExecuteRunController extends BaseController {
  final RunRepository _runRepo;
  ExecuteRunController(this._runRepo);

  final store = Get.find<LocalStorageService>();
  final firebaseStorage = Get.find<FirebaseStorageService>();

  StreamSubscription? _locationSubscription;
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  Rx<Marker?> marker = (null as Marker?).obs;
  final RxSet<Polyline> polyline = <Polyline>{}.obs;
  List<LatLng> latlngs = [];
  late LocationSettings locationSettings;
  Rx<Duration> runDuration = const Duration().obs;
  Timer? timer = null;

  RxBool isRunning = false.obs;
  RxBool isToggleRun = false.obs;

  bool isGoogleMapDisposed = false;

  @override
  void onInit() {
    super.onInit();

    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
          forceLocationManager: false,
          intervalDuration: const Duration(milliseconds: 200),
          foregroundNotificationConfig: const ForegroundNotificationConfig(
            notificationIcon: AndroidResource(name: "runner"),
            notificationText: "You are running",
            notificationTitle: "Running App By Vu",
            enableWakeLock: true,
          ));
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: 10,
        pauseLocationUpdatesAutomatically: true,
        showBackgroundLocationIndicator: false,
      );
    } else {
      locationSettings = const LocationSettings(
          accuracy: LocationAccuracy.high, distanceFilter: 10);
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
        isRunWithExercise: 0);
    await const Duration(seconds: 3).delay();
    var img = await controller.takeSnapshot();
    firebaseStorage.uploadImage("run$id", img!, (url) async {
      run.img = url;
      await _runRepo.insertRun(run: run);

      if (isShowLoading()) {
        dismissLoading();
      }
      onBack();
    }, (message) async {
      await _runRepo.insertRun(run: run);

      if (isShowLoading()) {
        dismissLoading();
      }
      onBack();
    });
  }

  addTime() {
    const addMilliSecond = 10;
    final milliSeconds = runDuration.value.inMilliseconds + addMilliSecond;
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
      width: 5
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
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        timeLimit: const Duration(milliseconds: 5000));
  }

  getCurrentLocation(BuildContext context) async {
    try {
      Uint8List imageData = await getMarker(context);
      if (!isToggleRun.value) {
        showLoading(messaging: "Processing...");
        var location = await determinePosition();
        print('Location: $location');

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
        print(
            'Location stream: Position: $position, isGoogleMapDisposed: $isGoogleMapDisposed, isRunning: ${isRunning.value}');
        if (position != null && isRunning.value) {
          controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  bearing: 192.8334901395799,
                  target: LatLng(position.latitude, position.longitude),
                  tilt: 0,
                  zoom: 18.00)));
          updateMarkerAndPolylines(position, imageData);
        }
        if (isShowLoading()) {
          dismissLoading();
        }
      }, onError: (e) => print("Error location: $e"));
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
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

  onBack() {
    Get.find<PlayMusicController>().onStopAudioPlayer();
    Get.back();
  }

  @override
  void onClose() {
    polyline.clear();
    onDisposeLocationSubscription();
    onDisposeGoogleMapController();
    stopTimer();
    super.onClose();
  }
}

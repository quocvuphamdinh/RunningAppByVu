import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:running_app_flutter/base/base_controller.dart';
import 'package:running_app_flutter/config/res/app_color.dart';

class ExecuteRunBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExecuteRunController());
  }
}

class ExecuteRunController extends BaseController {
  StreamSubscription? _locationSubscription;
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  Rx<Marker?> marker = (null as Marker?).obs;
  final RxSet<Polyline> polyline = <Polyline>{}.obs;
  List<LatLng> latlngs = [];
  late LocationSettings locationSettings;

  RxBool isRunning = false.obs;
  RxBool isToggleRun = false.obs;

  bool isGoogleMapDisposed = false;

  @override
  void onInit() {
    super.onInit();

    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
          forceLocationManager: true,
          intervalDuration: const Duration(milliseconds: 200),
          foregroundNotificationConfig: const ForegroundNotificationConfig(
            notificationText:
                "Running App By Vu will continue to receive your location even when you aren't using it",
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

  toggleRunning() {
    isRunning.value = !isRunning.value;
    isToggleRun.value = true;
  }

  Future<Uint8List> getMarker(BuildContext context) async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/icons/ic_run.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(Position newLocalData, Uint8List imageData) {
    toggleRunning();
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    marker.value = Marker(
        markerId: const MarkerId("runner"),
        position: latlng,
        rotation: newLocalData.heading,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: const Offset(0.5, 0.5),
        icon: BitmapDescriptor.fromBytes(imageData, size: Size(100, 100)));

    latlngs.add(latlng);

    polyline.add(Polyline(
      polylineId: PolylineId(newLocalData.toString()),
      visible: true,
      points: latlngs,
      color: AppColor.blackColor,
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
      var location = await determinePosition();

      updateMarkerAndCircle(location, imageData);

      onDisposeLocationSubscription();

      if (!isGoogleMapDisposed) {
        var controller = await mapController.future;
        _locationSubscription =
            Geolocator.getPositionStream(locationSettings: locationSettings)
                .listen((Position? position) {
          if (position != null) {
            print("Current position - ${DateTime.now()}: $position");
            controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    bearing: 192.8334901395799,
                    target: LatLng(position.latitude, position.longitude),
                    tilt: 0,
                    zoom: 18.00)));
            updateMarkerAndCircle(position, imageData);
          }
        });
      }
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
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
    onDisposeLocationSubscription();
    onDisposeGoogleMapController();
    super.onClose();
  }
}

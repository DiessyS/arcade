import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  late LocationSettings locationSettings;
  late Stream<Position> positionStream;

  LocationPermission isPermissionGranted = LocationPermission.denied;

  LocationService() {
    positionStream = const Stream.empty();

    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = _androidLocationSettings();
    } else if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS) {
      locationSettings = _iosLocationSettings();
    } else {
      locationSettings = _genericLocationSettings();
    }
  }

  init() async {
    var locationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!locationEnabled) {
      await Geolocator.openLocationSettings();
    }

    isPermissionGranted = await Geolocator.checkPermission();

    if (isPermissionGranted == LocationPermission.denied) {
      await Geolocator.requestPermission();

      isPermissionGranted = await Geolocator.checkPermission();
    }
  }

  capture() async {
    if (isPermissionGranted == LocationPermission.denied) {
      throw Exception('Location permission denied');
    }

    if (positionStream != const Stream.empty()) {
      return;
    }

    positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).asBroadcastStream();
  }

  dispose() {
    positionStream = const Stream.empty();
  }

  _androidLocationSettings() {
    return AndroidSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 1,
      forceLocationManager: true,
      intervalDuration: const Duration(seconds: 5),
    );
  }

  _iosLocationSettings() {
    return AppleSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      activityType: ActivityType.otherNavigation,
      distanceFilter: 1,
      pauseLocationUpdatesAutomatically: true,
    );
  }

  _genericLocationSettings() {
    return const LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 1,
    );
  }
}

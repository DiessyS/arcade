import 'dart:async';
import 'package:geolocator/geolocator.dart';

class LocationService {
  bool _canBroadcastLocation = false;
  bool _isBroadcastingLocation = false;
  Stream<Position>? _broadcastLocation;

  Future init() async {
    await serviceEnabled();
    await requestLocationPermission();
    _canBroadcastLocation = true;
  }

  Stream<Position>? getLocation() {
    if (!_isBroadcastingLocation) {
      startLocationBroadcast();
    }
    return _broadcastLocation;
  }

  startLocationBroadcast() {
    if (!_canBroadcastLocation) {
      throw Exception("Location service is not initialized");
    }

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 0,
    );

    _broadcastLocation = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).asBroadcastStream();

    _isBroadcastingLocation = true;
  }

  stopLocationBroadcast() {
    _broadcastLocation = null;
  }

  Future<Position> determinePosition() async {
    await serviceEnabled();
    await requestLocationPermission();
    return await Geolocator.getCurrentPosition();
  }

  Future serviceEnabled() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Location services are disabled");
    }
  }

  Future requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permissions are denied");
      } else if (permission == LocationPermission.deniedForever) {
        throw Exception("Location permissions are permanently denied, we cannot request permissions.");
      }
    }
  }
}

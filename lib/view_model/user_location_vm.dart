import 'package:arcade/service/location_service.dart';
import 'package:arcade/service_registers.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class UserLocationVM extends ChangeNotifier {
  Stream<Position>? getLocationStream() {
    return service<LocationService>().getLocation();
  }

  Future<LatLng> getUserLocation() async {
    return locationDataToLatLng(await service<LocationService>().determinePosition());
  }

  LatLng locationDataToLatLng(Position locationData) {
    return LatLng(locationData.latitude, locationData.longitude);
  }
}

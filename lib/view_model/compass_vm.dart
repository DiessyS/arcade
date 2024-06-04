import 'package:arcade/models/event.dart';
import 'package:arcade/service/location_service.dart';
import 'package:arcade/service/map_service.dart';
import 'package:arcade/service_registers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class CompassVM extends ChangeNotifier {
  Stream<Position>? location;
  LatLng? target;
  String? targetName;

  double minimumEndTrackingDistance = 10;
  int timerIntervalDisablingTracking = 5000;
  bool isTrackingFinished = false;

  startTracking(Event target) {
    isTrackingFinished = false;
    location = service<LocationService>().getLocation();
    this.target = target.asLatLng();
    targetName = target.name;
    notifyListeners();
  }

  getDirection(Position location) {
    if (!isTracking()) {
      return;
    }
    double bearing = service<MapService>().calculateBearing(
      location.latitude,
      location.longitude,
      target!.latitude,
      target!.longitude,
    );
    return bearing / 360;
  }

  getDistance(Position location) {
    var distance = FlutterMapMath().distanceBetween(
      location.latitude,
      location.longitude,
      target!.latitude,
      target!.longitude,
      'meters',
    );
    return distance;
  }

  isTrackingCloseEnough(double distance) {
    return distance < minimumEndTrackingDistance;
  }

  isTracking() {
    return location != null && target != null;
  }

  stopTracking() {
    location = null;
    target = null;
    targetName = null;
    notifyListeners();
  }

  stopTrackingDelayed() {
    isTrackingFinished = true;
    Future.delayed(Duration(milliseconds: timerIntervalDisablingTracking), () {
      stopTracking();
    });
  }
}

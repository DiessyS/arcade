import 'dart:math';

import 'package:arcade/enum/event_type.dart';
import 'package:arcade/service_registers.dart';
import 'package:latlong2/latlong.dart';

import '../models/event.dart';
import 'models/event_service.dart';


class MapService {
  late final LatLng initialLocation;

  MapService() {
    initialLocation = _getInitialLocation();
  }

  Future<bool> isLatLngInsideLimit(LatLng latLng) async {
    List<Event> limit = await service<EventService>().getByEventType(EventType.limit);

    if (limit.isEmpty) {
      return true;
    }

    var polyPoints = limit.map((e) => LatLng(e.marker.latitude, e.marker.longitude)).toList();
    var x = latLng.latitude, y = latLng.longitude;

    var inside = false;
    for (var i = 0, j = polyPoints.length - 1; i < polyPoints.length; j = i++) {
      var xi = polyPoints[i].latitude, yi = polyPoints[i].longitude;
      var xj = polyPoints[j].latitude, yj = polyPoints[j].longitude;

      var intersect = ((yi > y) != (yj > y)) && (x < (xj - xi) * (y - yi) / (yj - yi) + xi);
      if (intersect) inside = !inside;
    }

    return inside;
  }

  double calculateBearing(double lat1, double lon1, double lat2, double lon2) {
    double dLon = _degreesToRadians(lon2 - lon1);
    lat1 = _degreesToRadians(lat1);
    lat2 = _degreesToRadians(lat2);

    double y = sin(dLon) * cos(lat2);
    double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
    double bearing = atan2(y, x);

    return (_radiansToDegrees(bearing) + 360) % 360;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  double _radiansToDegrees(double radians) {
    return radians * 180 / pi;
  }

  LatLng _getInitialLocation() {
    return const LatLng(-25.051366806523237, -50.13217808780914);
  }
}

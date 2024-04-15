import 'dart:math';

import 'package:arcade/models/event_model.dart';
import 'package:arcade/models/multi_event_model.dart';

class MapService {
  isEventInsideLimit(EventModel event, MultiEventModel limit) {
    var polyPoints = limit.asLatLngList();
    var x = event.asLatLng().latitude, y = event.asLatLng().longitude;

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
}

import 'package:latlong2/latlong.dart';

class Marker {
  int id = 0;

  double latitude = 0.0;
  double longitude = 0.0;
  double altitude = 0.0;

  Marker();

  Marker.fromLatLng(LatLng latLng) {
    latitude = latLng.latitude;
    longitude = latLng.longitude;
  }

  LatLng toLatLng() {
    return LatLng(latitude, longitude);
  }

  @override
  String toString() {
    return 'Marker{id: $id, latitude: $latitude, longitude: $longitude, altitude: $altitude}';
  }

  toJson() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'altitude': altitude,
    };
  }

  Marker.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return;
    }

    latitude = json['latitude'];
    longitude = json['longitude'];
    altitude = json['altitude'];
  }
}

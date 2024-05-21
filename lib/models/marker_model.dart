import 'package:latlong2/latlong.dart';

class MarkerModel {
  double latitude = 0.0;
  double longitude = 0.0;
  double altitude = 0.0;

  fromLatLng(LatLng latLng) {
    latitude = latLng.latitude;
    longitude = latLng.longitude;
  }

  LatLng toLatLng() {
    return LatLng(latitude, longitude);
  }
}

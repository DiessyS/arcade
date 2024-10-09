import 'package:arcade/models/event.dart';
import 'package:latlong2/latlong.dart';

class PathDTO {
  Event begin;
  Event end;

  PathDTO({
    required this.begin,
    required this.end,
  });

  LatLng getTailLatLng() {
    return end.asLatLng();
  }
}

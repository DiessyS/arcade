import 'package:arcade/enum/multi_event_type.dart';
import 'package:arcade/models/marker_model.dart';
import 'package:latlong2/latlong.dart';

class MultiEventModel {
  String title = '';
  String userId = '';
  MultiEventType type = MultiEventType.limit;
  List<MarkerModel> markers = [];

  List<LatLng> asLatLngList() {
    if (markers.isEmpty) {
      return [];
    }

    return markers.map((e) => e.toLatLng()).toList();
  }
}

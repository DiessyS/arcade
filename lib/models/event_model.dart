import 'package:arcade/enum/event_type.dart';
import 'package:arcade/models/marker_model.dart';

class EventModel {
  String title = '';
  String description = '';
  String userId = '';
  EventType type = EventType.place;
  MarkerModel marker = MarkerModel();

  asLatLng() {
    return marker.toLatLng();
  }

  @override
  String toString() {
    return title;
  }
}

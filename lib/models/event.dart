import 'package:arcade/enum/event_type.dart';
import 'package:latlong2/latlong.dart';

import 'marker.dart';
import 'user.dart';

class Event {
  int id = 0;

  String identifier = "";
  String reference = "";
  EventType eventType = EventType.place;

  Marker marker = Marker();
  User createdBy = User();
  DateTime? createdAt;

  Event();

  LatLng asLatLng() {
    return marker.toLatLng();
  }

  @override
  String toString() {
    return identifier;
  }

  toJson() {
    return {
      'id': id,
      'identifier': identifier,
      'reference': reference,
      'eventType': eventType.value,
      'marker': marker.toJson(),
      'createdBy': createdBy.toJson(),
    };
  }

  Event.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    identifier = map['identifier'];
    reference = map['reference'];
    eventType = EventType.fromString(map['eventType']);
    marker = Marker.fromJson(map['marker']);
    createdBy = User.fromJson(map['createdBy']);
    createdAt = map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null;
  }
}

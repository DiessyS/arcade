import 'package:arcade/enum/event_type.dart';

import 'marker.dart';
import 'user.dart';

class Event {
  int id = 0;

  String name = "";
  String description = '';
  EventType eventType = EventType.place;

  Marker marker = Marker();
  User createdBy = User();

  Event();

  asLatLng() {
    return marker.toLatLng();
  }

  @override
  String toString() {
    return 'Event{id: $id, name: $name, description: $description, eventType: $eventType}';
  }

  toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'eventType': eventType,
      'marker': marker.toJson(),
      'createdBy': createdBy.toJson(),
    };
  }

  Event.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    description = map['description'];
    eventType = EventType.fromString(map['eventType']);
    marker = Marker.fromJson(map['marker']);
    createdBy = User.fromJson(map['createdBy']);
  }
}

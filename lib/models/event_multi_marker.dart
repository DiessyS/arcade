import 'package:arcade/enum/event_multi_marker_type.dart';

import 'marker.dart';
import 'user.dart';

class EventMultiMarker {
  int id = 0;

  String name = "";
  String description = '';
  String eventType = EventMultiMarkerType.limit.toString();

  List<Marker> markers = [];
  User createdBy = User();

  EventMultiMarker();

  @override
  String toString() {
    return 'EventMultiMarker{id: $id, name: $name, description: $description, eventType: $eventType}';
  }

  toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'eventType': eventType,
      'markers': markers.map((element) => element.toJson()).toList(),
      'createdBy': createdBy.toJson(),
    };
  }

  EventMultiMarker.fromJson(Map<String, dynamic> map) {
    name = map['name'];
    description = map['description'];
    eventType = map['eventType'];
    markers.addAll((map['markers'] as List).map((e) => Marker.fromJson(e)).toList());
  }
}

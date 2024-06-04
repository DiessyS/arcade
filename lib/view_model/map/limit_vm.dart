import 'package:arcade/models/event.dart';
import 'package:arcade/models/marker.dart';
import 'package:arcade/service/auth/auth_service.dart';
import 'package:arcade/service/map_service.dart';
import 'package:arcade/service_registers.dart';
import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';

import '../../enum/event_type.dart';
import '../../service/models/event_service.dart';

class LimitVM extends ChangeNotifier {
  late bool insertingLimit;
  late List<Event> limitBuffer;

  LimitVM() {
    insertingLimit = false;
    limitBuffer = [];
  }

  insertLimit(LatLng latlng) {
    Event event = Event();
    event.eventType = EventType.limit;
    event.name = 'Limite';
    event.description = 'Limite do mapa';
    event.createdBy = service<AuthService>().user!;
    event.marker = Marker.fromLatLng(latlng);

    limitBuffer.add(event);

    insertingLimit = true;
    notifyListeners();
  }

  saveLimit() async {
    await service<EventService>().deleteByEventType(EventType.limit);

    for (Event event in limitBuffer) {
      await service<EventService>().add(event);
    }

    insertingLimit = false;
    limitBuffer = [];
    notifyListeners();
  }

  resetLimit() {
    insertingLimit = false;
    limitBuffer = [];
    notifyListeners();
  }

  Future<List<LatLng>> getLimit() async {
    if (insertingLimit) {
      return limitBuffer.map((e) => e.marker.toLatLng()).toList();
    }
    List<Event> limit = await service<EventService>().getByEventType(EventType.limit);
    return limit.map((e) => e.marker.toLatLng()).toList();
  }

  Future<bool> isInsideLimit(LatLng latlng) async {
    return service<MapService>().isLatLngInsideLimit(latlng);
  }
}

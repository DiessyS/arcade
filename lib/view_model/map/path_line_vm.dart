import 'package:arcade/enum/event_type.dart';
import 'package:arcade/models/event.dart';
import 'package:arcade/models/marker.dart';
import 'package:arcade/service/auth/auth_service.dart';
import 'package:arcade/service/models/event_service.dart';
import 'package:arcade/service_registers.dart';
import 'package:arcade/view_model/map/dto/path_dto.dart';
import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';

class PathLineVM extends ChangeNotifier {
  late List<PathDTO> paths;
  late List<PathDTO> pathBuffer;
  late bool insertingPath;

  LatLng? begin;
  LatLng? end;

  PathLineVM() {
    insertingPath = false;
    paths = [];
    pathBuffer = [];
  }

  startPathInsertion() {
    insertingPath = true;
    notifyListeners();
  }

  cancelPathInsertion() {
    insertingPath = false;
    pathBuffer = [];
    begin = null;
    end = null;
    notifyListeners();
  }

  insertPathNode(LatLng latlng) {
    if (begin == null) {
      begin = latlng;
    } else {
      end = latlng;
      insertPath(begin!, end!);
      begin = null;
      end = null;
    }
    notifyListeners();
  }

  insertPath(LatLng begin, LatLng end) {
    const Uuid uuid = Uuid();
    final String uniqueId = uuid.v4();

    final Event beginEvent = Event()
      ..identifier = uniqueId
      ..eventType = EventType.path
      ..createdBy = service<AuthService>().user!
      ..marker = Marker.fromLatLng(begin);

    final Event endEvent = Event()
      ..identifier = uniqueId
      ..eventType = EventType.path
      ..createdBy = service<AuthService>().user!
      ..marker = Marker.fromLatLng(end);

    final PathDTO path = PathDTO(begin: beginEvent, end: endEvent);

    pathBuffer.add(path);
  }

  deletePaths() async {
    await service<EventService>().deleteByEventType(EventType.path);
    paths = [];
    notifyListeners();
  }

  saveLimit() async {
    for (PathDTO event in pathBuffer) {
      await service<EventService>().add(event.begin);
      await service<EventService>().add(event.end);
    }
    pathBuffer = [];
    insertingPath = false;
    begin = null;
    end = null;
    notifyListeners();
  }

  Future<List<PathDTO>> getPaths() async {
    final List<Event> events = await service<EventService>().getByEventType(EventType.path);
    final List<String> uniqueIds = [];

    paths.clear();

    for (Event event in events) {
      if (!uniqueIds.contains(event.identifier)) {
        uniqueIds.add(event.identifier);
      }
    }

    for (String uniqueId in uniqueIds) {
      final List<Event> pathEvents = events.where((element) => element.identifier == uniqueId).toList();

      if (pathEvents.length != 2) {
        throw Exception("Wrong path size");
      }

      final PathDTO path = PathDTO(begin: pathEvents[0], end: pathEvents[1]);
      paths.add(path);
    }

    return paths + pathBuffer;
  }
}

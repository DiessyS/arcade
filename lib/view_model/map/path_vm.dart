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

class PathVM extends ChangeNotifier {
  late List<LatLng> polylineBuffer;
  late List<PathDTO> pathBuffer;
  late List<PathDTO> paths;
  late bool insertingPath;
  late bool isUnsaved;

  PathVM() {
    insertingPath = false;
    isUnsaved = false;
    paths = [];
    polylineBuffer = [];
    pathBuffer = [];
  }

  insertPathNode(LatLng latlng) {
    insertingPath = true;
    isUnsaved = true;
    polylineBuffer.add(latlng);

    if (polylineBuffer.length == 2) {
      insertPath(polylineBuffer[0], polylineBuffer[1]);
      resetInsertion();
      return;
    }

    notifyListeners();
  }

  startInsertionByReference(LatLng latlng) {
    insertingPath = true;
    polylineBuffer.add(latlng);
    notifyListeners();
  }

  insertPathNodeWithReference(LatLng latlng) {
    polylineBuffer.add(latlng);

    if (polylineBuffer.length != 2) {
      resetInsertion();
      throw Exception("Wrong buffer size");
    }

    insertPath(polylineBuffer[0], polylineBuffer[1]);
    resetInsertion();
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

  bool isPathEmpty() {
    return pathBuffer.isEmpty;
  }

  void resetInsertion() {
    insertingPath = false;
    polylineBuffer = [];
    notifyListeners();
  }

  void cancelInsertion() {
    insertingPath = false;
    polylineBuffer = [];
    pathBuffer = [];
    isUnsaved = false;
    notifyListeners();
  }

  saveLimit() async {
    for (PathDTO event in pathBuffer) {
      await service<EventService>().add(event.begin);
      await service<EventService>().add(event.end);
    }
    isUnsaved = false;
    notifyListeners();
  }

  Future<List<PathDTO>> getPaths() async {
    final List<Event> events = await service<EventService>().getByEventType(EventType.path);
    final List<PathDTO> paths = [];
    final List<String> uniqueIds = [];

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

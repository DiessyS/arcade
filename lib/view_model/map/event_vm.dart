import 'package:arcade/enum/event_type.dart';
import 'package:arcade/models/event.dart';
import 'package:arcade/models/marker.dart';
import 'package:arcade/service/auth/auth_service.dart';
import 'package:arcade/service/models/event_service.dart';
import 'package:arcade/service_registers.dart';
import 'package:flutter/material.dart';

class EventVM extends ChangeNotifier {
  Future addEvent(String name, String description, EventType eventType, Marker marker) async {
    Event event = Event();
    event.name = name;
    event.description = description;
    event.eventType = eventType;
    event.marker = marker;
    event.createdBy = service<AuthService>().user!;

    await service<EventService>().add(event);
    notifyListeners();
  }

  Future deleteEvent(int id) async {
    await service<EventService>().delete(id);
    notifyListeners();
  }

  Future<List<Event>> getPlaceAndTempEvents() async {
    List<Event> permanentPlaces = await service<EventService>().getByEventType(EventType.place);
    List<Event> tempPlaces = await service<EventService>().getByEventType(EventType.temp);
    return [...permanentPlaces, ...tempPlaces];
  }

  Future<List<Event>> getPlacesEvents() async {
    return await service<EventService>().getByEventType(EventType.place);
  }
}

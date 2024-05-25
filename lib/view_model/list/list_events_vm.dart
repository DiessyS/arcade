import 'package:arcade/models/event.dart';
import 'package:arcade/service/models/event_service.dart';
import 'package:arcade/service_registers.dart';
import 'package:flutter/cupertino.dart';

class ListEventsVM extends ChangeNotifier {
  Future<List<Event>> getEvents() async {
    List<Event> places = await service<EventService>().getAll();
    return places;
  }
}

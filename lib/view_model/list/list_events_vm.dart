import 'package:arcade/models/event_model.dart';
import 'package:arcade/service/models/event_service.dart';
import 'package:arcade/service_registers.dart';
import 'package:flutter/cupertino.dart';

class ListEventsVM extends ChangeNotifier {
  List<EventModel> getEvents() {
    List<EventModel> places = service<EventService>().getAll();
    return places;
  }
}

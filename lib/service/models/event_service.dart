import 'dart:convert';

import 'package:arcade/models/event.dart';
import 'package:arcade/service/http/http_service.dart';
import 'package:arcade/service_registers.dart';
import 'package:http/http.dart';

class EventService {
  Future<List<Event>> getAll() async {
    Response response = await service<HttpService>().get('/event', authenticated: true);
    List<Event> events = [];

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (var item in data) {
        events.add(Event.fromJson(item));
      }
      return events;
    } else {
      throw Exception(response.body);
    }
  }
}

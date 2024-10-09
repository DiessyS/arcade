import 'dart:convert';

import 'package:arcade/models/event.dart';
import 'package:arcade/service_registers.dart';
import 'package:http/http.dart';

import 'http/arcade_backend_service.dart';

class FindService {
  Future<List<Event>> find(Event origin, Event target) async {
    final Response response = await service<ArcadeBackendService>().post(
      '/find',
      {
        'origin': origin.toJson(),
        'destination': target.toJson(),
      },
      authenticated: true,
    );

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

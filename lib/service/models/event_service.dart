import 'dart:convert';

import 'package:arcade/enum/event_type.dart';
import 'package:arcade/models/event.dart';
import 'package:arcade/service/http/http_service.dart';
import 'package:arcade/service_registers.dart';
import 'package:http/http.dart';

class EventService {
  Future add(Event event) async {
    Response response = await service<HttpService>().post(
      '/event',
      event.toJson(),
      authenticated: true,
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return response;
  }

  Future delete(int id) async {
    Response response = await service<HttpService>().delete(
      '/event/$id',
      authenticated: true,
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return response;
  }

  Future<List<Event>> getByEventType(EventType type) async {
    Response response = await service<HttpService>().get(
      '/event/type/${type.value}',
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

  Future deleteByEventType(EventType type) async {
    Response response = await service<HttpService>().delete(
      '/event/type/${type.value}',
      authenticated: true,
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return response;
  }
}

import 'package:flutter/material.dart';

enum EventType {
  initial(color: null, value: 'initial', label: 'inicial'),
  place(color: Colors.indigo, value: 'place', label: 'local'),
  temp(color: Colors.blue, value: 'temp', label: 'Local temporário'),
  path(color: Colors.greenAccent, value: 'path', label: 'Caminho'),
  limit(color: Colors.red, value: 'limit', label: 'Limite');

  final Color? color;
  final String value;
  final String label;

  const EventType({
    required this.color,
    required this.value,
    required this.label,
  });

  static EventType fromString(String label) {
    switch (label) {
      case 'initial':
        return EventType.initial;
      case 'place':
        return EventType.place;
      case 'temp':
        return EventType.temp;
      case 'path':
        return EventType.path;
      case 'limit':
        return EventType.limit;
      default:
        throw Exception('Tipo de evento desconhecido');
    }
  }
}

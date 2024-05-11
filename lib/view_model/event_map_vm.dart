import 'package:arcade/service/map_service.dart';
import 'package:arcade/service_registers.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class EventMapVM extends ChangeNotifier {
  LatLng getInitialLocation() {
    return service<MapService>().initialLocation;
  }
}

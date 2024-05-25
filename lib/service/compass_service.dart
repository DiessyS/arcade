import 'package:arcade/models/event.dart';
import 'package:arcade/service/location_service.dart';
import 'package:arcade/service_registers.dart';
import 'package:geolocator/geolocator.dart';

class CompassService {
  Stream<Position>? location;
  Event? target;

  late bool tracking;

  CompassService() {
    tracking = false;
  }

  setRoute(Event target) {
    location = service<LocationService>().getLocation();
    this.target = target;
  }
}

import 'package:arcade/models/event_model.dart';
import 'package:arcade/service/location_service.dart';
import 'package:arcade/service_registers.dart';
import 'package:geolocator/geolocator.dart';

class CompassService {
  Stream<Position>? location;
  EventModel? target;

  late bool tracking;

  CompassService() {
    tracking = false;
  }

  setRoute(EventModel target) {
    location = service<LocationService>().getLocation();
    this.target = target;
  }
}

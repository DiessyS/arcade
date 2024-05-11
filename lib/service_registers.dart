import 'package:arcade/service/compass_service.dart';
import 'package:arcade/service/location_service.dart';
import 'package:arcade/service/map_service.dart';
import 'package:arcade/service/models/event_service.dart';
import 'package:arcade/service/models/multi_event_service.dart';
import 'package:arcade/service/models/user_service.dart';
import 'package:get_it/get_it.dart';

GetIt service = GetIt.instance;

void serviceRegister() {
  service.registerLazySingleton<MapService>(() => MapService());
  service.registerLazySingleton<LocationService>(() => LocationService());
  service.registerLazySingleton<CompassService>(() => CompassService());

  service.registerLazySingleton<EventService>(() => EventService());
  service.registerLazySingleton<MultiEventService>(() => MultiEventService());
  service.registerLazySingleton<UserService>(() => UserService());
}

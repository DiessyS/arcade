import 'package:arcade/service/auth/auth_service.dart';
import 'package:arcade/service/compass_service.dart';
import 'package:arcade/service/find_service.dart';
import 'package:arcade/service/health_service.dart';
import 'package:arcade/service/http/arcade_backend_service.dart';
import 'package:arcade/service/location_service.dart';
import 'package:arcade/service/map_service.dart';
import 'package:arcade/service/models/event_service.dart';
import 'package:arcade/service/models/user_service.dart';
import 'package:get_it/get_it.dart';

GetIt service = GetIt.instance;

void serviceRegister() {
  service.registerLazySingleton<HealthService>(() => HealthService());
  service.registerLazySingleton<ArcadeBackendService>(() => ArcadeBackendService());
  service.registerLazySingleton<MapService>(() => MapService());
  service.registerLazySingleton<LocationService>(() => LocationService());
  service.registerLazySingleton<CompassService>(() => CompassService());
  service.registerLazySingleton<EventService>(() => EventService());
  service.registerLazySingleton<UserService>(() => UserService());
  service.registerLazySingleton<AuthService>(() => AuthService());
  service.registerLazySingleton<FindService>(() => FindService());
}

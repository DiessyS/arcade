import 'package:arcade/service/location_service.dart';
import 'package:arcade/service/map_service.dart';
import 'package:get_it/get_it.dart';

GetIt service = GetIt.instance;

void serviceRegister() {
  service.registerLazySingleton<MapService>(() => MapService());
  service.registerLazySingleton<LocationService>(() => LocationService());
}

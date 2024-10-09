import 'package:arcade/service_registers.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import 'http/arcade_backend_service.dart';

class HealthService {
  Future<bool> isBackendOperational() async {
    Response response;

    try {
      response = await service<ArcadeBackendService>().get('/ping');
    } catch (e) {
      return false;
    }

    return response.statusCode == 200;
  }

  Future<bool> isMapServiceOperational() async {
    final url = Uri.parse('https://tile.openstreetmap.org');
    int status = 0;

    try {
      status = (await http.get(url)).statusCode;
    } catch (e) {
      return false;
    }

    return status == 200 || status == 304;
  }
}

import 'package:arcade/service_registers.dart';
import 'package:http/http.dart';

import 'http/http_service.dart';

class ServerService {
  Future<bool> serverAvailable() async {
    Response response;

    try {
      response = await service<HttpService>().get('/ping');
    } catch (e) {
      return false;
    }

    return response.statusCode == 200;
  }
}

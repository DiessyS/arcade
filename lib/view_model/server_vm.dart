import 'package:arcade/service/server_service.dart';
import 'package:arcade/service_registers.dart';
import 'package:flutter/cupertino.dart';

class ServerVM extends ChangeNotifier {
  Future isServerAvailable() async {
    return await service<ServerService>().serverAvailable();
  }
}

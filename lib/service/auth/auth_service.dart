import 'dart:convert';

import 'package:arcade/models/user.dart';
import 'package:arcade/service/http/http_service.dart';
import 'package:arcade/service_registers.dart';
import 'package:http/http.dart';

class AuthService {
  String authToken = '';
  User? user;

  isAuthenticated() {
    return authToken.isNotEmpty;
  }

  login(String identifier, String password) async {
    Response response = await service<HttpService>().post('/login', {
      'identifier': identifier,
      'password': password,
    });

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      authToken = data['token'];
      user = User.fromJson(data['user']);
    } else {
      throw Exception(response.body);
    }
  }

  logout() {
    authToken = '';
    user = null;
  }
}

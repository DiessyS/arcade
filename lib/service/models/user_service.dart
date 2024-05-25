import 'dart:convert';

import 'package:arcade/models/user.dart';
import 'package:arcade/service/http/http_service.dart';
import 'package:arcade/service_registers.dart';
import 'package:http/http.dart';

class UserService {
  Future<List<User>> getAll() async {
    Response response = await service<HttpService>().get('/user', authenticated: true);
    List<User> users = [];

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (var item in data) {
        users.add(User.fromJson(item));
      }
      return users;
    } else {
      throw Exception(response.body);
    }
  }
}

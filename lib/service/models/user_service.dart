import 'dart:convert';

import 'package:arcade/models/user.dart';
import 'package:arcade/service/http/arcade_backend_service.dart';
import 'package:arcade/service_registers.dart';
import 'package:http/http.dart';

class UserService {
  Future<List<User>> getAll() async {
    Response response = await service<ArcadeBackendService>().get('/user', authenticated: true);
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

  Future update(int id, bool banned) async {
    Response response = await service<ArcadeBackendService>().put(
      '/user/$id',
      {'banned': banned.toString()},
      authenticated: true,
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return response;
  }

  Future delete(int id) async {
    Response response = await service<ArcadeBackendService>().delete(
      '/user/$id',
      authenticated: true,
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return response;
  }
}

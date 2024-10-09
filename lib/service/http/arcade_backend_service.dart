import 'dart:convert';
import 'package:arcade/service/auth/auth_service.dart';
import 'package:arcade/service_registers.dart';
import 'package:http/http.dart' as http;

class ArcadeBackendService {
  late final String baseUrl;

  ArcadeBackendService() {
    baseUrl = 'http://192.168.15.12:8080';
  }

  Future<http.Response> get(String endpoint, {bool authenticated = false}) async {
    final url = Uri.parse('$baseUrl$endpoint');

    Map<String, String>? headers = {};

    if (authenticated) {
      headers['Authorization'] = service<AuthService>().authToken;
    }

    return await http.get(url, headers: headers);
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> data, {bool authenticated = false}) async {
    final url = Uri.parse('$baseUrl$endpoint');

    Map<String, String>? headers = {'Content-Type': 'application/json'};

    if (authenticated) {
      headers['Authorization'] = service<AuthService>().authToken;
    }

    return await http.post(
      url,
      headers: headers,
      body: json.encode(data),
    );
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> data, {bool authenticated = false}) async {
    final url = Uri.parse('$baseUrl$endpoint');

    Map<String, String>? headers = {'Content-Type': 'application/json'};

    if (authenticated) {
      headers['Authorization'] = service<AuthService>().authToken;
    }

    return await http.put(
      url,
      headers: headers,
      body: json.encode(data),
    );
  }

  Future<http.Response> delete(String endpoint, {bool authenticated = false}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    Map<String, String>? headers = {};

    if (authenticated) {
      headers['Authorization'] = service<AuthService>().authToken;
    }

    return await http.delete(url, headers: headers);
  }
}

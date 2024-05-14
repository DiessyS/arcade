import 'package:http/http.dart' as http;

class HttpService {
  late String serverUrl;

  HttpService() {
    serverUrl = 'http://localhost:8080';
  }

  Future<Map<String, dynamic>> get(String path) async {
    var response = await http.get(Uri.parse('$serverUrl$path'));
    return response.body as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> post(String path, Map<String, dynamic> data) async {
    var response = await http.post(Uri.parse('$serverUrl$path'), body: data);
    return response.body as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> put(String path, Map<String, dynamic> data) async {
    var response = await http.put(Uri.parse('$serverUrl$path'), body: data);
    return response.body as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> delete(String path) async {
    var response = await http.delete(Uri.parse('$serverUrl$path'));
    return response.body as Map<String, dynamic>;
  }
}

class HttpService {
  late String server;

  HttpService() {
    server = 'http://localhost:3000';
  }

  Future<Map> get(String path) async {
    return {};
  }

  Future<Map> post(String path, Map data) async {
    return {};
  }

  Future<Map> put(String path, Map data) async {
    return {};
  }

  Future<Map> delete(String path) async {
    return {};
  }
}

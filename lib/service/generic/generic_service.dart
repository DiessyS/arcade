import 'package:arcade/service/http/http_service.dart';
import 'package:arcade/service_registers.dart';

class GenericService<T> {
  String urlSubPath;

  GenericService({required this.urlSubPath});

  Future<T?> get(int id) async {
    T? result;
    Map response = await service<HttpService>().get('$urlSubPath/$id');

    if (response['status'] == 200) {
      result = (T as dynamic).fromJson(response['data']);
    } else {
      throw Exception('Failed to get $urlSubPath/$id');
    }

    return result;
  }

  Future<List<T>> getAll() async {
    List<T> result = [];
    Map response = await service<HttpService>().get(urlSubPath);

    if (response['status'] == 200) {
      for (Map item in response['data']) {
        result.add((T as dynamic).fromJson(item));
      }
    } else {
      throw Exception('Failed to get $urlSubPath');
    }

    return result;
  }

  Future<T> add(T item) async {
    T result;
    Map response = await service<HttpService>().post(urlSubPath, (item as dynamic).toJson());

    if (response['status'] == 201) {
      result = (T as dynamic).fromJson(response['data']);
    } else {
      throw Exception('Failed to add $urlSubPath');
    }

    return result;
  }

  Future<T> update(T item) async {
    T result;
    Map response = await service<HttpService>().put('$urlSubPath/${(item as dynamic).id}', (item as dynamic).toJson());

    if (response['status'] == 200) {
      result = (T as dynamic).fromJson(response['data']);
    } else {
      throw Exception('Failed to update $urlSubPath/${(item as dynamic).id}');
    }

    return result;
  }

  Future<T> delete(int id) async {
    T result;
    Map response = await service<HttpService>().delete('$urlSubPath/$id');

    if (response['status'] == 200) {
      result = (T as dynamic).fromJson(response['data']);
    } else {
      throw Exception('Failed to delete $urlSubPath/$id');
    }

    return result;
  }
}

import 'package:arcade/repository/core/repository_interface.dart';

class GenericModelService<T> {
  late RepositoryInterface<T> repository;

  List<T> getAll() {
    return repository.getAll();
  }

  T getById(int id) {
    return repository.getById(id);
  }

  void add(T item) {
    repository.add(item);
  }

  void remove(T item) {
    repository.remove(item);
  }

  void update(T item) {
    repository.update(item);
  }

  void clear() {
    repository.clear();
  }
}

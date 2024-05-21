abstract class RepositoryInterface<T> {
  List<T> getAll();

  T getById(int id);

  void add(T item);

  void remove(T item);

  void update(T item);

  void clear();
}

class Repository<T> {
  List<T> _cache = [];

  List<T> getAll() {
    return _cache;
  }

  T getById(int id) {
    return _cache.firstWhere((item) => (item as dynamic).id == id);
  }

  void add(T item) {
    _cache.add(item);
  }

  void remove(T item) {
    _cache.remove(item);
  }

  void update(T item) {
    final index = _cache.indexWhere((element) => (element as dynamic).id == (item as dynamic).id);
    _cache[index] = item;
  }

  void clear() {
    _cache.clear();
  }
}

class User {
  int id = 0;

  String identifier = '';

  String name = '';

  bool banned = false;
  bool manager = true;

  User();

  @override
  String toString() {
    return 'User{id: $id, identifier: $identifier, name: $name, banned: $banned}';
  }

  toJson() {
    return {
      'id': id,
      'identifier': identifier,
      'name': name,
      'banned': banned,
    };
  }

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    identifier = json['identifier'];
    name = json['name'];
    banned = json['banned'];
  }
}

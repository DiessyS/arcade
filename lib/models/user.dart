class User {
  int id = 0;

  String identifier = '';

  String name = '';

  bool banned = false;
  bool manager = true;
  bool crudOnTempEvents = true;
  bool crudOnPermEvents = true;

  User();

  @override
  String toString() {
    return 'User{id: $id, identifier: $identifier, name: $name, banned: $banned, crudOnTempEvents: $crudOnTempEvents, crudOnPermEvents: $crudOnPermEvents}';
  }

  toJson() {
    return {
      'id': id,
      'identifier': identifier,
      'name': name,
      'banned': banned,
      'crudOnTempEvents': crudOnTempEvents,
      'crudOnPermEvents': crudOnPermEvents,
    };
  }

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    identifier = json['identifier'];
    name = json['name'];
    banned = json['banned'];
    crudOnTempEvents = json['crudOnTempEvents'];
    crudOnPermEvents = json['crudOnPermEvents'];
  }
}

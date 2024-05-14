import 'package:arcade/service/generic/generic_service.dart';
import 'package:arcade_repository/arcade_repository.dart';

class UserService extends GenericService<User> {
  UserService() : super(urlSubPath: 'user');
}

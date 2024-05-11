import 'package:arcade/models/user_model.dart';
import 'package:arcade/repository/user_repository.dart';
import 'package:arcade/service/models/generic_model_service.dart';

class UserService extends GenericModelService<UserModel> {
  UserService() {
    repository = UserRepository();
  }
}

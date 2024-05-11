import 'package:arcade/enum/user_type.dart';
import 'package:arcade/models/user_model.dart';
import 'package:arcade/service/models/user_service.dart';
import 'package:arcade/service_registers.dart';

bootstrap() async {
  addTestUser();
}

addTestUser() {
  UserModel user = UserModel();
  user.id = '1';
  user.ra = '123456789';
  user.name = 'John Doe';
  user.type = UserType.user;

  service<UserService>().add(user);
}

import 'package:arcade/models/user_model.dart';
import 'package:arcade/service/auth/jwt.dart';

class AuthService {
  //JWT? jwt;
  UserModel? user;

  isAuthenticated() {
    return user != null;
  }
}

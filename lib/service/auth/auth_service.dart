import 'package:arcade_repository/models/user.dart';

class AuthService {
  String? jwt;
  User? user;

  isAuthenticated() {
    return user != null;
  }
}

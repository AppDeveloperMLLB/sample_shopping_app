import 'package:sample_shopping_app/src/features/authentication/domain/model/authentication_info.dart';

class AuthenticationApplicationService {
  Future<void> login(String email, String password) {
    final info = AuthenticationInfo(email: email, password: password);
    throw Exception();
  }

  Future<void> register(String email, String password) {
    final info = AuthenticationInfo(email: email, password: password);
    throw Exception();
  }

  Future<void> logout() {
    throw Exception();
  }
}

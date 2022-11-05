import 'package:sample_shopping_app/src/features/authentication/domain/model/authentication_info.dart';
import 'package:sample_shopping_app/src/features/authentication/domain/model/user.dart';

abstract class AuthenticationRepository {
  Future<void> login(AuthenticationInfo info);
  Future<void> register(AuthenticationInfo info);
  Future<void> logout();
  Stream<User?> authStateChanges();
  User? get currentUser;
}

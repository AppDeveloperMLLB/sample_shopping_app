import 'package:sample_shopping_app/src/features/authentication/domain/model/authentication_info.dart';
import 'package:sample_shopping_app/src/features/authentication/domain/repository/authentication_reporisory.dart';

class InMemoryAuthenticationRepository implements AuthenticationRepository {
  InMemoryAuthenticationRepository._();
  static final instance = InMemoryAuthenticationRepository._();
  List<AuthenticationInfo> _userList = [
    AuthenticationInfo(email: "test@test.com", password: "12345678"),
  ];

  @override
  Future<void> login(AuthenticationInfo info) async {
    if (userExists(info)) {
      return;
    }

    throw Exception("User is not exist");
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> register(AuthenticationInfo info) async {
    if (userExists(info)) {
      throw Exception("User exists.");
    }

    _userList.add(info);
  }

  bool userExists(AuthenticationInfo info) {
    return _userList.any((element) => element.email == info.email);
  }
}

import 'package:sample_shopping_app/src/features/authentication/domain/model/authentication_info.dart';
import 'package:sample_shopping_app/src/features/authentication/domain/repository/authentication_reporisory.dart';
import 'package:sample_shopping_app/src/utils/in_memory_store.dart';

class InMemoryAuthenticationRepository implements AuthenticationRepository {
  InMemoryAuthenticationRepository._();
  static final instance = InMemoryAuthenticationRepository._();
  final List<AuthenticationInfo> _userList = [
    AuthenticationInfo(email: "test@test.com", password: "12345678"),
  ];
  final _authState = InMemoryStore<AuthenticationInfo?>(null);

  @override
  Stream<AuthenticationInfo?> authStateChanges() => _authState.stream;

  @override
  AuthenticationInfo? get currentUser => _authState.value;

  @override
  Future<void> login(AuthenticationInfo info) async {
    await Future.delayed(const Duration(seconds: 2));
    if (userExists(info)) {
      _authState.value = info;
      return;
    }

    throw Exception("User not found.");
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 2));
    _authState.value = null;
  }

  @override
  Future<void> register(AuthenticationInfo info) async {
    await Future.delayed(const Duration(seconds: 2));
    if (userExists(info)) {
      throw Exception("User exists.");
    }

    _userList.add(info);
    _authState.value = info;
  }

  bool userExists(AuthenticationInfo info) {
    return _userList.any((element) => element.email == info.email);
  }
}

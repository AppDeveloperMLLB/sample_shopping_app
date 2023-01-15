import 'package:sample_shopping_app/src/features/authentication/domain/model/authentication_info.dart';
import 'package:sample_shopping_app/src/features/authentication/domain/model/user.dart';
import 'package:sample_shopping_app/src/features/authentication/domain/repository/authentication_reporisory.dart';
import 'package:sample_shopping_app/src/utils/in_memory_store.dart';
import 'package:uuid/uuid.dart';

class InMemoryAuthenticationRepository implements AuthenticationRepository {
  InMemoryAuthenticationRepository._();
  static final instance = InMemoryAuthenticationRepository._();
  static const User testUser = User(
    id: "0001",
    email: "test@test.com",
    password: "12345678",
  );
  final List<User> _userList = [
    testUser,
  ];

  final _authState = InMemoryStore<User?>(null);

  @override
  Stream<User?> authStateChanges() => _authState.stream;

  @override
  User? get currentUser => _authState.value;

  @override
  Future<void> login(AuthenticationInfo info) async {
    await Future.delayed(const Duration(seconds: 2));
    final loginUser = getUser(info);
    if (loginUser != null) {
      _authState.value = loginUser;
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

    if (getUser(info) != null) {
      throw Exception("User exists.");
    }

    final newId = const Uuid().v4();
    final newUser = User(id: newId, email: info.email, password: info.password);
    _userList.add(newUser);
    _authState.value = newUser;
  }

  User? getUser(AuthenticationInfo info) {
    final index = _userList.indexWhere((element) =>
        element.email == info.email && element.password == info.password);
    if (index == -1) {
      return null;
    }

    return _userList[index];
  }
}

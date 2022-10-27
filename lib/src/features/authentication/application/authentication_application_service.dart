import 'package:sample_shopping_app/src/features/authentication/domain/model/authentication_info.dart';
import 'package:sample_shopping_app/src/features/authentication/domain/repository/authentication_reporisory.dart';
import 'package:sample_shopping_app/src/locator/repository_locator.dart';

class AuthenticationApplicationService {
  Future<void> login(String email, String password) async {
    final info = AuthenticationInfo(email: email, password: password);
    final repo = RepositoryLocator.instance.get<AuthenticationRepository>();
    await repo.login(info);
  }

  Future<void> register(String email, String password) async {
    final info = AuthenticationInfo(email: email, password: password);
    final repo = RepositoryLocator.instance.get<AuthenticationRepository>();
    await repo.register(info);
  }

  Future<void> logout() async {
    final repo = RepositoryLocator.instance.get<AuthenticationRepository>();
    await repo.logout();
  }

  AuthenticationInfo? getCurrentUser() {
    final repo = RepositoryLocator.instance.get<AuthenticationRepository>();
    return repo.currentUser;
  }

  Stream<AuthenticationInfo?> authStateChange() {
    final repo = RepositoryLocator.instance.get<AuthenticationRepository>();
    return repo.authStateChanges();
  }
}

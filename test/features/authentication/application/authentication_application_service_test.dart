import 'package:flutter_test/flutter_test.dart';
import 'package:sample_shopping_app/src/features/authentication/application/authentication_application_service.dart';
import 'package:sample_shopping_app/src/features/authentication/data/repository/in_memory_authentication_repository.dart';
import 'package:sample_shopping_app/src/features/authentication/domain/model/user.dart';
import 'package:sample_shopping_app/src/locator/repository_locator.dart';

void main() {
  RepositoryLocator.instance.add(InMemoryAuthenticationRepository.instance);
  final service = AuthenticationApplicationService();

  test('login', () async {
    final initUser = service.getCurrentUser();
    expect(initUser, null);

    await service.login("test@test.com", "12345678");
    final user = service.getCurrentUser();
    expect(user!.id, "0001");
    expect(user.email, "test@test.com");
    expect(user.password, "12345678");
  });

  test('loginStream', () async {
    final stream = service.authStateChange();
    stream.listen(
      (event) {
        if (event == null) return;
        expect(
          event,
          const User(
            id: "0001",
            email: "test@test.com",
            password: "12345678",
          ),
        );
      },
    );
    await service.login("test@test.com", "12345678");
  });
}

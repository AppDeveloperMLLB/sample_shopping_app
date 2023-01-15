import 'package:flutter_test/flutter_test.dart';
import 'package:sample_shopping_app/src/features/authentication/application/authentication_application_service.dart';
import 'package:sample_shopping_app/src/features/authentication/data/repository/in_memory_authentication_repository.dart';
import 'package:sample_shopping_app/src/features/authentication/domain/model/user.dart';
import 'package:sample_shopping_app/src/locator/repository_locator.dart';

void main() {
  // If you try to use other repository, please change repository here.
  RepositoryLocator.instance.add(InMemoryAuthenticationRepository.instance);
  final service = AuthenticationApplicationService();
  group("sucess to login", () {
    test('login', () async {
      final initUser = service.getCurrentUser();
      expect(initUser, null);

      const testUser = InMemoryAuthenticationRepository.testUser;
      await service.login(testUser.email, testUser.password);
      final user = service.getCurrentUser();
      expect(user!.id, testUser.id);
      expect(user.email, testUser.email);
      expect(user.password, testUser.password);
    });

    test('loginStream', () async {
      const testUser = InMemoryAuthenticationRepository.testUser;
      final stream = service.authStateChange();
      stream.listen(
        (event) {
          if (event == null) return;
          expect(
            event,
            User(
              id: testUser.id,
              email: testUser.email,
              password: testUser.password,
            ),
          );
        },
      );
      await service.login(testUser.email, testUser.password);
    });
  });

  group("failed to login", () {
    test("not exist user", () async {
      const notExistUser =
          User(id: "xxxxx", email: "xxxxx@mail.com", password: "xxxxx");
      expectLater(
        service.login(
          notExistUser.email,
          notExistUser.password,
        ),
        throwsException,
      );
    });

    test("incorrect password", () async {
      const testUser = InMemoryAuthenticationRepository.testUser;
      expectLater(
        service.login(testUser.email, "xxxxxx"),
        throwsException,
      );
    });

    test("incorrect email", () async {
      const testUser = InMemoryAuthenticationRepository.testUser;
      expectLater(
        service.login(
          "xxxxxx@mail.com",
          testUser.password,
        ),
        throwsException,
      );
    });
  });

  group("logout", () {
    test("logout", () async {
      const testUser = InMemoryAuthenticationRepository.testUser;
      await service.login(testUser.email, testUser.password);
      final user = service.getCurrentUser();
      expect(user, testUser);
      await service.logout();
      expectLater(service.getCurrentUser(), null);
    });

    test("logout stream", () async {
      const testUser = InMemoryAuthenticationRepository.testUser;
      await service.login(testUser.email, testUser.password);
      final stream = service.authStateChange();
      expect(stream, emitsInOrder([testUser, null]));
      service.logout();
    });
  });

  group("success to register", () {
    test("register new user", () async {
      expect(service.getCurrentUser(), null);
      const newUserEmail = "test02@test.com";
      const newUserPassword = "abcdefgh";
      await service.register(newUserEmail, newUserPassword);
      final registeredUser = service.getCurrentUser();
      expect(registeredUser!.email, newUserEmail);
      expect(registeredUser.password, newUserPassword);
    });
  });

  group("failed to register", () {
    test("register exist user", () async {
      const existUser = InMemoryAuthenticationRepository.testUser;
      expectLater(
        service.register(
          existUser.email,
          existUser.password,
        ),
        throwsException,
      );
    });
  });
}

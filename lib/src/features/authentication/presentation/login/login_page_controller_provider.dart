import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/features/authentication/application/authentication_application_service.dart';
import 'package:sample_shopping_app/src/features/authentication/domain/model/authentication_info.dart';
import 'package:sample_shopping_app/src/features/authentication/domain/repository/authentication_reporisory.dart';
import 'package:sample_shopping_app/src/locator/repository_locator.dart';

final loginPageControllerProvider =
    StateNotifierProvider<LoginPageControllerNotifier, AsyncValue<void>>((ref) {
  return LoginPageControllerNotifier();
});

class LoginPageControllerNotifier extends StateNotifier<AsyncValue<void>> {
  LoginPageControllerNotifier() : super(const AsyncValue.data(null));

  Future<void> login(String email, String password) async {
    final service = AuthenticationApplicationService();
    state = await AsyncValue.guard(() => service.login(email, password));
  }
}

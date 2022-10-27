import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/features/authentication/application/authentication_application_service.dart';
import 'package:sample_shopping_app/src/features/authentication/presentation/login/login_page_state.dart';

final loginPageControllerProvider = StateNotifierProvider<
    LoginPageControllerNotifier, AsyncValue<LoginPageState>>((ref) {
  return LoginPageControllerNotifier();
});

enum LoginType {
  singIn,
  register,
}

class LoginPageControllerNotifier
    extends StateNotifier<AsyncValue<LoginPageState>> {
  LoginPageControllerNotifier()
      : super(
          const AsyncValue.data(
            LoginPageState(
              loginType: LoginType.singIn,
              value: AsyncData(null),
            ),
          ),
        );

  Future<void> login(String email, String password) async {
    state = const AsyncLoading<LoginPageState>().copyWithPrevious(state);
    final service = AuthenticationApplicationService();
    final newState =
        await AsyncValue.guard(() => service.login(email, password));
    state = AsyncData(state.value!.copyWith(value: newState));
  }

  void switchLoginType() {
    final currentLoginType = state.value?.loginType ?? LoginType.singIn;
    final newLoginType = currentLoginType == LoginType.singIn
        ? LoginType.register
        : LoginType.singIn;
    state = AsyncData(state.value!.copyWith(loginType: newLoginType));
  }

  void clearError() {
    state = AsyncData(state.value!.copyWith(value: const AsyncData(null)));
  }
}

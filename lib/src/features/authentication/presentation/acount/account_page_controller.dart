import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/features/authentication/application/authentication_application_service.dart';
import 'package:sample_shopping_app/src/features/authentication/domain/model/authentication_info.dart';

final accountPageControllerProvider =
    StateNotifierProvider<AccountPageControllerProvider, AsyncValue<void>>(
        (ref) {
  return AccountPageControllerProvider();
});

class AccountPageControllerProvider extends StateNotifier<AsyncValue<void>> {
  AccountPageControllerProvider() : super(const AsyncData(null));

  Future<void> logout() async {
    final authApplicationService = AuthenticationApplicationService();
    state = await AsyncValue.guard(() => authApplicationService.logout());
  }

  AuthenticationInfo? getCurrentUser() {
    final authApplicationService = AuthenticationApplicationService();
    return authApplicationService.getCurrentUser();
  }
}

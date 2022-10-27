import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sample_shopping_app/src/features/authentication/presentation/login/login_page_controller_provider.dart';
part 'login_page_state.freezed.dart';

@freezed
abstract class LoginPageState implements _$LoginPageState {
  const LoginPageState._();
  const factory LoginPageState({
    required LoginType loginType,
    required AsyncValue<void> value,
  }) = _LoginPageState;

  String get buttonText =>
      loginType == LoginType.singIn ? "Sign in" : "Register";
  String get switchButtonText =>
      loginType == LoginType.singIn ? "Register?" : "Sign in?";
}

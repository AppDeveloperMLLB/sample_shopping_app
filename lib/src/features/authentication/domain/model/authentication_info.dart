import 'package:freezed_annotation/freezed_annotation.dart';
part 'authentication_info.freezed.dart';

@Freezed(copyWith: false)
abstract class AuthenticationInfo implements _$AuthenticationInfo{
  AuthenticationInfo._();

  factory AuthenticationInfo._internal({
    required String email,
    required String password,
  }) = _AuthenticationInfo;

  factory AuthenticationInfo({
    required String email,
    required String password,
  }){
    if(email.isEmpty){
      throw Exception("Email is empty.");
    }

    if (!RegExp(
        r"/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/)")
        .hasMatch(email)) {
      throw Exception("Email format is error.");
    }

    if(password.isEmpty){
      throw Exception("Password is empty.");
    }

    if(password.length < 8){
      throw Exception("Password is less than 8 characters.");
    }

    return AuthenticationInfo._internal(
      email : email,
      password : password,
    );
  }

  AuthenticationInfo copyWith({String? email, String? password}){
    final copiedEmail = email ?? this.email;
    final copiedPassword = password ?? this.password;

    return AuthenticationInfo(email: copiedEmail, password: copiedPassword);
  }
}
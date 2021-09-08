import 'package:equatable/equatable.dart';

import '../../models/models.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppLoaded extends AuthEvent {}

class UserSignInStart extends AuthEvent {
  final String email;
  final String password;

  UserSignInStart({required this.email, required this.password});
}

class UserSignInReset extends AuthEvent {}

class UserVerifyStart extends AuthEvent {
  final String code;

  UserVerifyStart({ required this.code });
}

class UserSignedOut extends AuthEvent {}
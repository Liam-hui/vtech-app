import 'package:equatable/equatable.dart';
import '../../models/models.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthNotDone extends AuthState {}

class AuthPending extends AuthState {
   final Account account;

  AuthPending({ required this.account });

  @override
  List<Object> get props => [account];
}

class AuthSuccess extends AuthState {
  final Account account;

  AuthSuccess({ required this.account });

  @override
  List<Object> get props => [account];
}

class AuthFail extends AuthState {
  final String message;

  AuthFail({required this.message});

  @override
  List<Object> get props => [message];
}

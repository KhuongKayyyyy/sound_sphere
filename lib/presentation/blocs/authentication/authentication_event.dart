part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationEventStarted extends AuthenticationEvent {}

class AuthLoginRequested extends AuthenticationEvent {
  final String email;
  final String password;

  const AuthLoginRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthLogoutRequested extends AuthenticationEvent {}

class AuthRegisterRequested extends AuthenticationEvent {
  final String email;
  final String password;
  final String displayName;

  const AuthRegisterRequested(
      {required this.email, required this.password, required this.displayName});

  @override
  List<Object> get props => [email, password, displayName];
}

class AuthGetUserRequested extends AuthenticationEvent {}

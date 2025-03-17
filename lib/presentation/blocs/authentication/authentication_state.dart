part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

// class AuthenticationSuccess extends AuthenticationState {
//   final User user;

//   const AuthenticationSuccess(this.user);

//   @override
//   List<Object> get props => [user];

//   @override
//   String toString() {
//     return "AuthenticationSuccess { user: $user }";
//   }
// }

// class AuthenticationFailure extends AuthenticationState {
//   final String message;

//   const AuthenticationFailure(this.message);

//   @override
//   List<Object> get props => [message];

//   @override
//   String toString() {
//     return "AuthenticationFailure { message: $message }";
//   }
// }

class AuthLoading extends AuthenticationState {}

class AuthLoginSuccess extends AuthenticationState {}

class AuthLoginFailure extends AuthenticationState {
  final String message;

  const AuthLoginFailure(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() {
    return "AuthLoginFailure { message: $message }";
  }
}

class AuthRegisterSuccess extends AuthenticationState {
  final AppUser user;

  const AuthRegisterSuccess(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() {
    return "AuthRegisterSuccess { user: $user }";
  }
}

class AuthRegisterFailure extends AuthenticationState {
  final String message;

  const AuthRegisterFailure(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() {
    return "AuthRegisterFailure { message: $message }";
  }
}

class AuthLogoutSuccess extends AuthenticationState {}

class AuthLogoutFailure extends AuthenticationState {
  final String message;

  const AuthLogoutFailure(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() {
    return "AuthLogoutFailure { message: $message }";
  }
}

class AuthGetUserSuccess extends AuthenticationState {
  final AppUser user;

  const AuthGetUserSuccess(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() {
    return "AuthGetUserSuccess { user: $user }";
  }
}

class AuthGetUserFailure extends AuthenticationState {
  final String message;

  const AuthGetUserFailure(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() {
    return "AuthGetUserFailure { message: $message }";
  }
}

@immutable
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

@immutable
class RegisterState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  bool get isValidEmailAndPassword => isEmailValid && isPasswordValid;

  const RegisterState({
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
  });

  factory RegisterState.inital() {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.loading() {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.failure() {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory RegisterState.success() {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  // clone an object of LoginState
  RegisterState cloneWith({
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return RegisterState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  // clone and update object of LoginState
  RegisterState cloneAndUpdate({
    bool? isEmailValid,
    bool? isPasswordValid,
  }) {
    return cloneWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
    );
  }
}

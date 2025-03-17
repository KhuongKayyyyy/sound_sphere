import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sound_sphere/core/error/exceptions.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:sound_sphere/data/models/app_user.dart';
import 'package:sound_sphere/data/res/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository = UserRepository();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  AuthenticationBloc() : super(AuthenticationInitial()) {
    // on<AuthenticationEventStarted>(_onAuthenticationStarted);
    // on<AuthenticationEventLoggedIn>(_onAuthenticationLoggedIn);
    // on<AuthenticationEventLoggedOut>(_onAuthenticationLoggedOut);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthGetUserRequested>(_onGetUserRequested);
  }

  Future<void> _onLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthenticationState> emit) async {
    emit(AuthLoading());
    try {
      await userRepository.logOutUser();
      emit(AuthLogoutSuccess());
    } on AuthenticationException catch (e) {
      emit(AuthLogoutFailure(e.message));
    } catch (e) {
      emit(AuthLogoutFailure("An unexpected error occurred"));
    }
  }

  Future<void> _onGetUserRequested(
      AuthGetUserRequested event, Emitter<AuthenticationState> emit) async {
    emit(AuthLoading());
    try {
      final user = await userRepository.getUser();
      emit(AuthGetUserSuccess(user));
    } on AuthenticationException catch (e) {
      emit(AuthGetUserFailure(e.message));
    } catch (e) {
      emit(AuthGetUserFailure("An unexpected error occurred"));
    }
  }

  // Handler for AuthLoginRequested
  Future<void> _onLoginRequested(
      AuthLoginRequested event, Emitter<AuthenticationState> emit) async {
    emit(AuthLoading());
    try {
      if (await userRepository.login(
          email: event.email, password: event.password)) {
        emit(AuthLoginSuccess());
      } else {
        emit(AuthLoginFailure("Invalid email or password"));
      }
    } on AuthenticationException catch (e) {
      emit(AuthLoginFailure(e.message));
    } catch (e) {
      emit(AuthLoginFailure("An unexpected error occurred"));
    }
  }

  Future<void> _onRegisterRequested(
      AuthRegisterRequested event, Emitter<AuthenticationState> emit) async {
    emit(AuthLoading());
    try {
      final user = await userRepository.register(
          email: event.email,
          password: event.password,
          name: event.displayName);
      emit(AuthRegisterSuccess(user));
    } on AuthenticationException catch (e) {
      emit(AuthRegisterFailure(e.message));
    } catch (e) {
      emit(AuthLoginFailure("An unexpected error occurred"));
    }
  }

  // Handler for AuthenticationEventStarted
  // Future<void> _onAuthenticationStarted(AuthenticationEventStarted event,
  //     Emitter<AuthenticationState> emit) async {
  //   final isSignedIn = await userRepository.isSignedIn();
  //   if (isSignedIn) {
  //     final user = await userRepository.getUser();
  //     emit(AuthenticationSuccess(user!));
  //   } else {
  //     emit(AuthenticationFailure("Not logged in"));
  //   }
  // }

  // // Handler for AuthenticationEventLoggedIn
  // Future<void> _onAuthenticationLoggedIn(AuthenticationEventLoggedIn event,
  //     Emitter<AuthenticationState> emit) async {
  //   final user = await userRepository.getUser();
  //   emit(AuthenticationSuccess(user!));
  // }

  // // Handler for AuthenticationEventLoggedOut
  // Future<void> _onAuthenticationLoggedOut(AuthenticationEventLoggedOut event,
  //     Emitter<AuthenticationState> emit) async {
  //   userRepository.signOut();
  //   emit(AuthenticationFailure("Logged out"));
  // }
}

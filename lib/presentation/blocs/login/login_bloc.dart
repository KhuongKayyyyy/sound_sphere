import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_sphere/core/validators/validator.dart';
import 'package:sound_sphere/data/res/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;
  LoginBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(LoginInitial()) {
    on<LoginEventEmailChanged>(_onEmailChanged);
    on<LoginEventPasswordChanged>(_onPasswordChanged);
    on<LoginEventWithEmailAndPasswordPressed>(_onLoginWithCredentials);
    on<LoginEventWithGooglePressed>(_onLoginWithGoogle);
  }

  @override
  void onTransition(Transition<LoginEvent, LoginState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  FutureOr<void> _onEmailChanged(
      LoginEventEmailChanged event, Emitter<LoginState> emit) {
    emit(state.cloneWith(isEmailValid: Validator.isValidEmail(event.email)));
  }

  FutureOr<void> _onPasswordChanged(
      LoginEventPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.cloneWith(
        isPasswordValid: Validator.isValidPassword(event.password)));
  }

  Future<void> _onLoginWithCredentials(
      LoginEventWithEmailAndPasswordPressed event,
      Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      await _userRepository.signInWithEmailAndPassword(
          event.email, event.password);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure());
    }
    // finally {
    //   emit(state.cloneWith(isSubmitting: false));
    // }
  }

  Future<void> _onLoginWithGoogle(
      LoginEventWithGooglePressed event, Emitter<LoginState> emit) async {
    try {
      await _userRepository.signInWithGoogle();
      emit(state.cloneWith(isSuccess: true));
    } catch (e) {
      emit(state.cloneWith(isFailure: true));
    }
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_sphere/core/validators/validator.dart';
import 'package:sound_sphere/data/res/firebase_user_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final FirebaseUserRepository _userRepository;
  RegisterBloc({required FirebaseUserRepository userRepository})
      : _userRepository = userRepository,
        super(RegisterInitial()) {
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterEventPressed>(_onRegisterPressed);
  }

  FutureOr<void> _onEmailChanged(
      RegisterEmailChanged event, Emitter<RegisterState> emit) {
    emit(state.cloneWith(isEmailValid: Validator.isValidEmail(event.email)));
  }

  FutureOr<void> _onPasswordChanged(
      RegisterPasswordChanged event, Emitter<RegisterState> emit) {
    emit(state.cloneWith(
        isPasswordValid: Validator.isValidPassword(event.password)));
  }

  Future<void> _onRegisterPressed(
      RegisterEventPressed event, Emitter<RegisterState> emit) async {
    try {
      await _userRepository.createUserWithEmailAndPassword(
          event.email, event.password);
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure());
    }
    // finally {
    //   emit(state.cloneWith(isSubmitting: false));
    // }
  }
}

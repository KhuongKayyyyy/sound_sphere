import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_sphere/core/validators/validator.dart';
import 'package:sound_sphere/data/res/user_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;
  RegisterBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(RegisterInitial()) {
    // on<RegisterEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
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
      emit(state.cloneWith(isSuccess: true));
    } catch (e) {
      emit(state.cloneWith(isFailure: true));
    }
    // finally {
    //   emit(state.cloneWith(isSubmitting: false));
    // }
  }
}

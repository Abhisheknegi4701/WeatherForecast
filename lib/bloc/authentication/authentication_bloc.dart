
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/authentication/authentication_event.dart';
import 'package:weather/bloc/authentication/authentication_state.dart';

import '../../data/repository/mainrepository.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>{
  AuthenticationBloc(this.repository)  : super(LoginState()) {
    on<LoginEvent>(_onLogin);
    on<SignUpEvent>(_onSigbUp);
  }
  final Repository repository;


  FutureOr<void> _onLogin(LoginEvent event, Emitter<AuthenticationState> emit) async {
    emit(LoginState());
  }

  FutureOr<void> _onSigbUp(SignUpEvent event, Emitter<AuthenticationState> emit) async {
    emit(SignUpState());
  }

}
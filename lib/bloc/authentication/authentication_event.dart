
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AuthenticationEvent extends Equatable{
  const AuthenticationEvent();
}

class LoginEvent extends AuthenticationEvent{
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class SignUpEvent extends AuthenticationEvent{
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

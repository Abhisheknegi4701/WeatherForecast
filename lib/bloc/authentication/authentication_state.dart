
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AuthenticationState extends Equatable{}

class LoginState extends AuthenticationState{
  @override
  List<Object?> get props =>[];
}

class SignUpState extends AuthenticationState{
  SignUpState();

  @override
  List<Object?> get props =>[];
}

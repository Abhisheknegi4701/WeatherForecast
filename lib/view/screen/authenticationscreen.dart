
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/view/screen/login.dart';
import 'package:weather/view/screen/signup.dart';

import '../../bloc/authentication/authentication_bloc.dart';
import '../../bloc/authentication/authentication_state.dart';
import '../../data/repository/mainrepository.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key, required this.repository});
  final Repository repository;

  static Route<void> route(Repository repository) {
    return MaterialPageRoute<void>(builder: (_) => AuthenticationScreen(repository: repository,));
  }

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
          body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is LoginState) {
                return LoginScreen(repository: widget.repository);
              } else if (state is SignUpState) {
                return SignUpScreen(
                  repository: widget.repository,
                );
              } else {
                return Container();
              }
            },
          ),
        ));
  }
}

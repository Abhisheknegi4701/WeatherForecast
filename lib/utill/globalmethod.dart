
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather/bloc/main/bloc_event.dart';

import '../bloc/authentication/authentication_bloc.dart';
import '../bloc/authentication/authentication_event.dart';
import '../bloc/home/home_bloc.dart';
import '../bloc/home/home_event.dart';
import '../bloc/main/bloc.dart';

showPrint(String title, dynamic message){
  print("$title  =>=>   $message");
}

openMainEvent(BuildContext context, BlocEvent event){
  context.read<MainBloc>().add(event);
}

openHomeEvent(BuildContext context, HomePageEvent event){
  context.read<HomePageBloc>().add(event);
}

openAuthenticationEvent(BuildContext context, AuthenticationEvent event){
  context.read<AuthenticationBloc>().add(event);
}

showToast(String message){
  Fluttertoast.showToast(
      backgroundColor: Colors.white,
      textColor: Colors.black,
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER);
}

bool isValidEmail(String email) {
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool isValidPassword(String password) {
  return RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[$!@#&*~%?])(?!.*\s).{8,}$")
      .hasMatch(password);
}

validateFields(var val, String hint, String error) {
  if (val.trim().isEmpty) {
    return error;
  }else{
    if(hint == "Email"){
      if(!isValidEmail(val.trim())){
        return "Enter Correct email ID";
      }
    }
    if(hint == "Password"){
      if(!isValidPassword(val.trim())){
        return "The password must have at least 8 characters, including one letter each in upper and lower capital, 1 special character and 1 number.";
      }
    }
  }
}








import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/data/datasource/remote/dio.dart';
import 'package:weather/utill/app_constants.dart';
import '../model/response/base/api_response.dart';

enum MainBlocStatus {authenticated, unauthenticated}

class Repository {
  final _controller = StreamController<MainBlocStatus>();
  final DioClient dioClient = DioClient(AppConstants.baseURL, Dio());

  Stream<MainBlocStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    final user = await SharedPreferences.getInstance();
    if(user.getBool(AppConstants.spLogin)?? false){
      yield MainBlocStatus.authenticated;
      //logIn(username: "asdds", password: "ddffdsfs");
    }else{
      yield MainBlocStatus.unauthenticated;
    }
    //yield MainBlocStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<String?> logIn({
    required String username,
    required String password,
  }) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final user = await SharedPreferences.getInstance();
    return await firebaseAuth.signInWithEmailAndPassword(email: username, password: password).then((value){
      if(value.user != null){
        user.setBool(AppConstants.spLogin, true);
        user.setString(AppConstants.spName, value.user!.displayName ?? "User");
        user.setString(AppConstants.spEmail, username);
        user.setString(AppConstants.spPassword, password);
        return AppConstants.success;
      }
    }).catchError((e){
      String error = "Server Error";
      if (e.code == 'user-not-found') {
        error = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        error = 'Wrong password provided for that user.';
      }else{
        error = e.message;
      }
      return error;
    });
  }

  Future<String?> createUser({
    required String username,
    required String email,
    required String password,
  }) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final sharedPreferences = await SharedPreferences.getInstance();
    return await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((value) async {
      if(value.user != null){
        User? user = value.user;

        await user?.updateDisplayName(username);
        sharedPreferences.setBool(AppConstants.spLogin, true);
        sharedPreferences.setString(AppConstants.spName, value.user!.displayName ?? "User");
        sharedPreferences.setString(AppConstants.spEmail, username);
        sharedPreferences.setString(AppConstants.spPassword, password);
        return AppConstants.success;
      }
    }).catchError((e){
      String error = "Server Error";
      if (e.code == 'user-not-found') {
        error = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        error = 'Wrong password provided for that user.';
      }else{
        error = e.message;
      }
      return error;
    });
  }

  Future<ApiResponse> getWeather(String city) async {
     try {

       var queryParameters = {
         "q": city,
         "appid": AppConstants.weatherAPIKey
       };

       final response = await dioClient.get(AppConstants.getWeather, queryParameters: queryParameters,);
       return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }

  Future<ApiResponse> getWeekWeather(String city) async {
    try {

      var queryParameters = {
        "q": city,
        "appid": AppConstants.weatherAPIKey
      };

      final response = await dioClient.get(AppConstants.getWeekWeather,
        queryParameters: queryParameters,);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }

  Future<bool> locationPermission()async{
    if(await Permission.location.serviceStatus.isEnabled){
      var status = await Permission.location.status;
      if(status.isGranted){
        return true;
      }else{
        return false;
      }
    }else{
      return false;
    }
  }

  Future<PermissionStatus?> askLocationPermission()async{
    Map<Permission, PermissionStatus> status = await [Permission.location].request();
    return status[Permission.location];
  }

  Future<String> getCurrentLocation()async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    return placemarks[0].locality ?? AppConstants.defaultCity;
  }

  Future<void> logOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(AppConstants.spLogin, false);
    _controller.add(MainBlocStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
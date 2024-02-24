import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/data/model/weekweather.dart';

import '../../data/model/weather.dart';
import '../../data/repository/mainrepository.dart';
import '../../utill/app_constants.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState>{
  HomePageBloc(this.repository)  : super(HomePageLoadingState()) {
    on<HomePageLoadingEvent>((event, emit) => mapHomePageLoadingToState(event, emit));
    on<HomePageMainEvent>(homePageMain);
    on<HomePageSearchEvent>(homePageSearch);
  }
  final Repository repository;
  String locality = AppConstants.defaultCity;
  WeatherData weatherData = WeatherData();
  WeekWeathers weekWeatherData = WeekWeathers();

  FutureOr<void> mapHomePageLoadingToState(HomePageLoadingEvent event, Emitter<HomePageState> emit,) async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      emit(HomePageLoadingState());
      final nowResult = await (Connectivity().checkConnectivity());
      if(nowResult != ConnectivityResult.none){
        locality = event.locality;
        var weatherResponse = await repository.getWeather(locality);
        if (weatherResponse.response != null) {
          Map<String, dynamic> weatherDataMap = Map<String, dynamic>.from(json.decode(weatherResponse.response.toString()));
          sharedPreferences.setString(AppConstants.spWeatherData, weatherResponse.response.toString());
          weatherData = WeatherData.fromJson(weatherDataMap);
        }else{
          String? weatherDataMap = sharedPreferences.getString(AppConstants.spWeatherData);
          if(weatherDataMap != null){
            Map<String, dynamic> weatherDataMap1 = Map<String, dynamic>.from(json.decode(weatherDataMap));
            weatherData = WeatherData.fromJson(weatherDataMap1);
          }else{
            weatherData = WeatherData();
          }
        }
        var weekWeatherResponse = await repository.getWeekWeather(locality);
        if (weekWeatherResponse.response != null) {
          Map<String, dynamic> weekWeatherDataMap = Map<String, dynamic>.from(json.decode(weekWeatherResponse.response.toString()));
          sharedPreferences.setString(AppConstants.spWeekWeatherData, weekWeatherResponse.response.toString());
          weekWeatherData = WeekWeathers.fromJson(weekWeatherDataMap);
        }else{
          String? weekWeatherDataMap = sharedPreferences.getString(AppConstants.spWeekWeatherData);
          if(weekWeatherDataMap != null){
            Map<String, dynamic> weekWeatherDataMap1 = Map<String, dynamic>.from(json.decode(weekWeatherDataMap));
            weekWeatherData = WeekWeathers.fromJson(weekWeatherDataMap1);
          }else{
            weekWeatherData = WeekWeathers();
          }
        }
        //emit(HomePageMainState(locality: locality, weatherData: weatherData, weekWeatherData: weekWeatherData));
      }else{
        String? weatherDataMap = sharedPreferences.getString(AppConstants.spWeatherData);
        if(weatherDataMap != null){
          Map<String, dynamic> weatherDataMap1 = Map<String, dynamic>.from(json.decode(weatherDataMap));
          weatherData = WeatherData.fromJson(weatherDataMap1);
        }else{
          weatherData = WeatherData();
        }
        String? weekWeatherDataMap = sharedPreferences.getString(AppConstants.spWeekWeatherData) ?? "";
        if(weekWeatherDataMap.isNotEmpty){
          Map<String, dynamic> weekWeatherDataMap1 = Map<String, dynamic>.from(json.decode(weekWeatherDataMap));
          weekWeatherData = WeekWeathers.fromJson(weekWeatherDataMap1);
        }else{
          weekWeatherData = WeekWeathers();
        }
      }
        emit(HomePageMainState(locality: locality, weatherData: weatherData, weekWeatherData: weekWeatherData));
    } catch (error) {
      // Handle errors if needed
      print('Error in HomePageLoadingEvent: $error');
    }
  }

  FutureOr<void> homePageMain(HomePageMainEvent event, Emitter<HomePageState> emit,) async {
    emit(HomePageMainState(locality: locality, weatherData: weatherData, weekWeatherData: weekWeatherData));
  }

  FutureOr<void> homePageSearch(HomePageSearchEvent event, Emitter<HomePageState> emit) async {
    emit(HomePageSearchState());
  }

}
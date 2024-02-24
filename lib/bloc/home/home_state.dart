
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../data/model/weather.dart';
import '../../data/model/weekweather.dart';

@immutable
abstract class HomePageState extends Equatable{}

class HomePageLoadingState extends HomePageState{
  @override
  List<Object?> get props =>[];
}

class HomePageSearchState extends HomePageState{
  HomePageSearchState();

  @override
  List<Object?> get props =>[];
}

class HomePageMainState extends HomePageState{
  final String locality;
  final WeatherData weatherData;
  final WeekWeathers weekWeatherData;

  HomePageMainState({required this.locality, required this.weatherData, required this.weekWeatherData});

  @override
  List<Object?> get props =>[];
}
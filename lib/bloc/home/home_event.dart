
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class HomePageEvent extends Equatable{
  const HomePageEvent();
}

class HomePageLoadingEvent extends HomePageEvent{
  final String locality;

  const HomePageLoadingEvent({required this.locality});

  @override
  List<Object?> get props =>[];
}

class HomePageMainEvent extends HomePageEvent{
  @override
  List<Object?> get props =>[];
}

class HomePageSearchEvent extends HomePageEvent{
  const HomePageSearchEvent();

  @override
  List<Object?> get props =>[];
}
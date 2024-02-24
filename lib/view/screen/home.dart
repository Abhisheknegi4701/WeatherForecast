
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather/bloc/home/home_event.dart';
import 'package:weather/utill/globalmethod.dart';
import 'package:weather/view/screen/search.dart';

import '../../bloc/home/home_bloc.dart';
import '../../bloc/home/home_state.dart';
import '../../data/repository/mainrepository.dart';
import '../../utill/app_constants.dart';
import 'homescreen.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.repository});
  final Repository repository;

  static Route<void> route(Repository repository) {
    return MaterialPageRoute<void>(builder: (_) => Home(repository: repository));
  }

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  getLocation() async {
    String locality;
    bool hasLocationPermission = await widget.repository.locationPermission();

    if (hasLocationPermission) {
      widget.repository.getCurrentLocation().then((locality) {
        if(mounted){
          openHomeEvent(context, HomePageLoadingEvent(locality: locality));
        }
      }).catchError((error){
        if(mounted){
          openHomeEvent(context, HomePageLoadingEvent(locality: AppConstants.defaultCity));
        }
      });
    } else {
      widget.repository.askLocationPermission().then((permissionStatus) async {
        if (permissionStatus == PermissionStatus.granted) {
          locality = await widget.repository.getCurrentLocation();
        } else {
          locality = AppConstants.defaultCity;
        }
        if(mounted){
          openHomeEvent(context, HomePageLoadingEvent(locality: locality));
        }
      }).catchError((error){
        if(mounted){
          openHomeEvent(context, HomePageLoadingEvent(locality: AppConstants.defaultCity));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            if(state is HomePageLoadingState){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }else if(state is HomePageSearchState){
              return CitySearch(repository: widget.repository,);
            }else if(state is HomePageMainState){
              return HomeScreen(repository: widget.repository, locality: state.locality, weatherData: state.weatherData, weekWeatherData: state.weekWeatherData);
            }else{
              return Container();
            }
          },
        )
    );
  }

}
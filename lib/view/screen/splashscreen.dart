
import 'dart:async';
import 'package:flutter/material.dart';
import '../../utill/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SplashScreen());
  }

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _route();
  }

  Future<void> _route() async {
    // if (await Provider.of<SplashProvider>(context, listen: false).locationPermission()) {
    //   if(mounted){
    //     Provider.of<SplashProvider>(context, listen: false).getCurrentLocation().then((value){
    //       if(value != null){
    //         Provider.of<HomeProvider>(context, listen: false).city = value;
    //         Navigator.pushNamedAndRemoveUntil(context, RouteHelper.home, (route) => false);
    //       }else{
    //         Provider.of<HomeProvider>(context, listen: false).city = AppConstants.defaultCity;
    //         Navigator.pushNamedAndRemoveUntil(context, RouteHelper.home, (route) => false);
    //       }
    //     });
    //   }
    // } else {
    //   if(mounted){
    //     Provider.of<SplashProvider>(context, listen: false).askLocationPermission().then((value){
    //       if(value! == PermissionStatus.granted){
    //         if(mounted){
    //           Provider.of<SplashProvider>(context, listen: false).getCurrentLocation().then((value){
    //             if(value != null){
    //               Provider.of<HomeProvider>(context, listen: false).city = value;
    //               Navigator.pushNamedAndRemoveUntil(context, RouteHelper.home, (route) => false);
    //             }else{
    //               Provider.of<HomeProvider>(context, listen: false).city = AppConstants.defaultCity;
    //               Navigator.pushNamedAndRemoveUntil(context, RouteHelper.home, (route) => false);
    //             }
    //           });
    //         }
    //       }else {
    //         Provider.of<HomeProvider>(context, listen: false).city = AppConstants.defaultCity;
    //         Navigator.pushNamedAndRemoveUntil(context, RouteHelper.home, (route) => false);
    //       }
    //     });
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(Images.appLogo, height: 130),
        ],
      ),
    );
  }
}


import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/view/screen/authenticationscreen.dart';
import 'package:weather/view/screen/home.dart';
import 'package:weather/view/screen/splashscreen.dart';
import 'bloc/authentication/authentication_bloc.dart';
import 'bloc/home/home_bloc.dart';
import 'bloc/main/bloc.dart';
import 'bloc/main/bloc_state.dart';
import 'data/repository/mainrepository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCtGGPhil5q7UiQTkAmyS-6vfnMSQGJxAI",
            projectId: "practice-95093",
            storageBucket: "practice-95093.appspot.com",
            messagingSenderId: "996334769143",
            appId: "1:996334769143:android:edd3a4d77592491e4994f2"));
  } else if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyD2H-mXC7ILcOyw_gkl9QnYPkzF2DybIaY",
            projectId: "practice-95093",
            storageBucket: "practice-95093.appspot.com",
            messagingSenderId: "996334769143",
            appId: "1:996334769143:ios:bbedf6542beb75294994f2"));
  } else {
    await Firebase.initializeApp();

  }
  runApp(MyApp(repository: Repository(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.repository});
  final Repository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider.value(
        value: repository,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => MainBloc(repository: repository),
            ),
            BlocProvider(
              create: (context) => AuthenticationBloc(repository),
            ),
            BlocProvider(
              create: (context) => HomePageBloc(repository),
            ),
          ],
          child: MyAppView(repository: repository),
        ),
      ),
    );
  }
}

class MyAppView extends StatefulWidget {
  const MyAppView({super.key, required this.repository});
  final Repository repository;

  @override
  State<MyAppView> createState() => _MyAppViewState();
}

class _MyAppViewState extends State<MyAppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      builder: (context, child){
        return BlocListener<MainBloc, BlocState>(
          listener: (context, state){
            print(state.status);
            switch(state.status){
              case MainBlocStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  Home.route(widget.repository),
                      (route) => false,
                );
                break;
              case MainBlocStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  AuthenticationScreen.route(widget.repository),
                      (route) => false,
                );
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashScreen.route(),
    );
  }
}

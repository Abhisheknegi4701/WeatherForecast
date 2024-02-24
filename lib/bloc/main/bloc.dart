
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/utill/app_constants.dart';

import '../../data/repository/mainrepository.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';

class MainBloc extends Bloc<BlocEvent, BlocState> {
  MainBloc({required this.repository})  : super(const BlocState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    blocStatus = repository.status.listen(
          (status) => add(AuthenticationStatusChanged(status)),
    );
  }
  final Repository repository;
  late StreamSubscription<MainBlocStatus> blocStatus;

  @override
  Future<void> close() {
    blocStatus.cancel();
    repository.dispose();
    return super.close();
  }

  Future<void> _onAuthenticationLogoutRequested(
      AuthenticationLogoutRequested event,
      Emitter<BlocState> emit,) async{
  }

  Future<void> _onAuthenticationStatusChanged(
      AuthenticationStatusChanged event,
      Emitter<BlocState> emit,
      ) async{
    switch (event.status) {
      case MainBlocStatus.unauthenticated:
        return emit(const BlocState.unauthenticated());
      case MainBlocStatus.authenticated:
        final user = await SharedPreferences.getInstance();
        if(user.getBool(AppConstants.spLogin)?? false){
          print("BlocState.authenticated");
          return emit(const BlocState.authenticated());
        }else{
            print("BlocState.unauthenticated");
            return emit(const BlocState.unauthenticated());
        }
      default:
        print("BlocState.unknown");
        return emit(const BlocState.unknown());
    }
  }

}

import 'package:equatable/equatable.dart';

import '../../data/repository/mainrepository.dart';

class BlocEvent extends Equatable{
  const BlocEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class AuthenticationStatusChanged extends BlocEvent {
  const AuthenticationStatusChanged(this.status);
  final MainBlocStatus status;

  @override
  List<Object> get props => [status];
}

class AuthenticationLogoutRequested extends BlocEvent {}
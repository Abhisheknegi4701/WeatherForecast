
import 'package:equatable/equatable.dart';

import '../../data/repository/mainrepository.dart';

class BlocState extends Equatable{
  const BlocState._({
    this.status = MainBlocStatus.unauthenticated
  });

  const BlocState.unknown() : this._();
  const BlocState.authenticated() : this._(status: MainBlocStatus.authenticated);
  const BlocState.unauthenticated() : this._(status: MainBlocStatus.unauthenticated);

  final MainBlocStatus status;

  @override
  // TODO: implement props
  List<Object?> get props => [status];
}

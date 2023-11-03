import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../domain/blocs/auth_bloc.dart';

enum LoaderViewCubitState { unknown, authorize, notAuthorize }

class LoaderViewCubit extends Cubit<LoaderViewCubitState> {
  final AuthBloc authBloc;
  late final StreamSubscription<AuthState> authBlocSubscription;
  LoaderViewCubit(super.initState, this.authBloc) {
    authBloc.add(AuthCheckStatusEvent());
    onState(authBloc.state);
    authBlocSubscription = authBloc.stream.listen(onState);
  }

  void onState(AuthState state) {
    if (state is AuthAuthorizeState) {
      emit(LoaderViewCubitState.authorize);
    } else if (state is AuthUnAuthorizeState) {
      emit(LoaderViewCubitState.notAuthorize);
    }
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }
}

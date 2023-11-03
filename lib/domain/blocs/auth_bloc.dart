// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../api_client/account_api_client/account_api_client.dart';
import '../api_client/auth_api_client/auth_api_client.dart';
import '../api_client/data_providers/session_data_provider.dart';

abstract class AuthEvent {}

class AuthLogoutEvent extends AuthEvent {}

class AuthCheckStatusEvent extends AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final String login;
  final String password;

  AuthLoginEvent({
    required this.login,
    required this.password,
  });
}

enum AuthStateStatus { authorize, notAuthorize, inProgress }

abstract class AuthState {}

class AuthAuthorizeState extends AuthState {}

class AuthUnAuthorizeState extends AuthState {
  AuthUnAuthorizeState();
}

class AuthFailureState extends AuthState {
  final Object error;

  AuthFailureState(this.error);

  @override
  bool operator ==(covariant AuthFailureState other) {
    if (identical(this, other)) return true;

    return other.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}

class AuthInProgressState extends AuthState {}

class AuthCheckInProgressState extends AuthState {}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _sessionDataProvider = SessionDataProvider();
  final _authClient = AuthApiClient();
  final _accountClient = AccountApiClient();

  AuthBloc(super.initialState) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthCheckStatusEvent) {
        await onAuthCheckStatusEventEvent(event, emit);
      } else if (event is AuthLoginEvent) {
        await onAuthLoginEventEvent(event, emit);
      } else if (event is AuthLogoutEvent) {
        await onAuthLogoutEvent(event, emit);
      }
    }, transformer: sequential());

    add(AuthCheckStatusEvent());
  }

  Future<void> onAuthCheckStatusEventEvent(
      AuthCheckStatusEvent event, Emitter<AuthState> emit) async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final newState =
        sessionId != null ? AuthAuthorizeState() : AuthUnAuthorizeState();

    emit(newState);
  }

  Future<void> onAuthLoginEventEvent(
      AuthLoginEvent event, Emitter<AuthState> emit) async {
    try {
      final sessionId = await _authClient.auth(
        username: event.login,
        password: event.password,
      );
      final accountId = await _accountClient.getAccountInfo(sessionId);

      await _sessionDataProvider.setSessionId(sessionId);
      await _sessionDataProvider.setAccountId(accountId);
      emit(AuthAuthorizeState());
    } catch (e) {
      emit(AuthFailureState(e));
    }
  }

  Future<void> onAuthLogoutEvent(
      AuthLogoutEvent event, Emitter<AuthState> emit) async {
    try {
      await _sessionDataProvider.deleteSessionId();
      await _sessionDataProvider.deleteAccountId();
      emit(AuthUnAuthorizeState());
    } catch (e) {
      emit(AuthFailureState(e));
    }
  }
}

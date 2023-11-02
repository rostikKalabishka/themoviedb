import '../../api_client/account_api_client/account_api_client.dart';
import '../../api_client/auth_api_client/auth_api_client.dart';
import '../../api_client/data_providers/session_data_provider.dart';
import 'package:bloc/bloc.dart';

abstract class AuthEvent {}

class AuthLogoutEvent {}

class AuthLoginEvent {
  final String login;
  final String password;

  AuthLoginEvent({
    required this.login,
    required this.password,
  });
}

enum AuthStateStatus { authorize, notAuthorize, inProgress }

abstract class AuthState {}

class AuthSuccessState extends AuthState {}

class AuthUnknownState extends AuthState {}

class AuthFailureState extends AuthState {}

class AuthInProgressState extends AuthState {
  final String error;

  AuthInProgressState(this.error);
}

class AuthService extends Bloc<AuthEvent, AuthState> {
  final _sessionDataProvider = SessionDataProvider();
  final _authClient = AuthApiClient();
  final _accountClient = AccountApiClient();

  AuthService() : super() {}

  Future<bool> isAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final isAuth = sessionId != null;
    return isAuth;
  }

  Future<void> login(String login, String password) async {
    final sessionId = await _authClient.auth(
      username: login,
      password: password,
    );
    final accountId = await _accountClient.getAccountInfo(sessionId);

    await _sessionDataProvider.setSessionId(sessionId);
    await _sessionDataProvider.setAccountId(accountId);
  }

  Future<void> logout() async {
    await _sessionDataProvider.deleteSessionId();
    await _sessionDataProvider.deleteAccountId();
  }
}

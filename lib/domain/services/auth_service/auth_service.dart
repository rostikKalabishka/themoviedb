import '../../api_client/account_api_client/account_api_client.dart';
import '../../api_client/auth_api_client/auth_api_client.dart';
import '../../api_client/data_providers/session_data_provider.dart';

//old
class AuthService {
  final _sessionDataProvider = SessionDataProvider();
  final _authClient = AuthApiClient();
  final _accountClient = AccountApiClient();

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

import '../../api_client/data_providers/session_data_provider.dart';

class AuthService {
  final _sessionDataProvide = SessionDataProvider();

  Future<bool> isAuth() async {
    final sessionId = await _sessionDataProvide.getSessionId();
    final isAuth = sessionId != null;
    return isAuth;
  }
}

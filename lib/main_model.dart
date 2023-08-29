import 'package:themoviedb/domain/api_client/data_providers/session_data_provider.dart';

class MainModel {
  final _sessionDataProvide = SessionDataProvider();
  var _isAuth = false;
  bool get isAuth => _isAuth;

  Future<void> checkAuth() async {
    final sessionId = await _sessionDataProvide.getSessionId();
    _isAuth = sessionId != null;
  }
}

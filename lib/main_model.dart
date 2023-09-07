import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/data_providers/session_data_provider.dart';
import 'package:themoviedb/ui/routes/routes.dart';

class MainModel {
  final _sessionDataProvide = SessionDataProvider();
  var _isAuth = false;
  bool get isAuth => _isAuth;

  Future<void> checkAuth() async {
    final sessionId = await _sessionDataProvide.getSessionId();
    _isAuth = sessionId != null;
  }

  Future<void> resetSession(BuildContext context) async {
    await _sessionDataProvide.setSessionId(null);
    await _sessionDataProvide.setAccountId(null);
    await Navigator.of(context).pushNamedAndRemoveUntil(
        MainNavigationRouteName.auth, (route) => false);
  }
}

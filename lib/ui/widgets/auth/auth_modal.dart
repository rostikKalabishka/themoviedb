import 'dart:async';

import 'package:flutter/material.dart';

import 'package:themoviedb/domain/api_client/data_providers/session_data_provider.dart';
import 'package:themoviedb/ui/routes/routes.dart';

import '../../../domain/api_client/account_api_client/account_api_client.dart';
import '../../../domain/api_client/api_client_exaption.dart';
import '../../../domain/api_client/auth_api_client/auth_api_client.dart';

class AuthModel extends ChangeNotifier {
  final _authClient = AuthApiClient();
  final _accountClient = AccountApiClient();
  final _sessionDataProvider = SessionDataProvider();

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;

    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Fill in your login and password';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();
    String? sessionId;
    int? accountId;
    try {
      sessionId = await _authClient.auth(
        username: login,
        password: password,
      );
      accountId = await _accountClient.getAccountInfo(sessionId);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          _errorMessage =
              'The server is unavailable. Check your internet connection';
          break;
        case ApiClientExceptionType.auth:
          _errorMessage = 'Incorrect login or password!';
          break;

        case ApiClientExceptionType.other:
          _errorMessage = 'There\'s been a mistake. Try again';
          break;
        default:
      }
    } catch (e) {
      _errorMessage = 'There\'s been a mistake. Try again';
    }
    _isAuthProgress = false;
    if (_errorMessage != null) {
      notifyListeners();
      return;
    }

    if (sessionId == null || accountId == null) {
      _errorMessage = 'Unknown error, try again';
      notifyListeners();
      return;
    }
    await _sessionDataProvider.setSessionId(sessionId);
    await _sessionDataProvider.setAccountId(accountId);
    unawaited(Navigator.of(context)
        .pushReplacementNamed(MainNavigationRouteName.mainScreen));
  }
}

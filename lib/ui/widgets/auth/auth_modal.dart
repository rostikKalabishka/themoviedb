import 'dart:async';
import 'package:flutter/material.dart';
import 'package:themoviedb/ui/routes/routes.dart';
import '../../../domain/api_client/api_client_exaption.dart';
import '../../../domain/services/auth_service/auth_service.dart';

class AuthModel extends ChangeNotifier {
  final _authClient = AuthService();

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  void navigatorToSignUp(BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigationRouteName.signUp);
  }

  void navigatorToResendEmail(BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigationRouteName.resendEmail);
  }

  bool _isValid(String login, String password) =>
      login.isNotEmpty && password.isNotEmpty;

  Future<String?> _loginErrorHandler(String login, String password) async {
    try {
      await _authClient.login(login, password);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          return 'The server is unavailable. Check your internet connection';

        case ApiClientExceptionType.auth:
          return 'Incorrect login or password!';

        case ApiClientExceptionType.other:
          return 'There\'s been a mistake. Try again';

        default:
      }
    } catch (e) {
      return 'Unknown error, try again';
    }
    return null;
  }

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;

    if (!_isValid(login, password)) {
      _update('Fill in your login and password', false);

      return;
    }

    _update(null, true);

    _errorMessage = await _loginErrorHandler(login, password);
    if (_errorMessage == null) {
      MainNavigation.resetNavigator(context);
    } else {
      _update(_errorMessage, false);
    }
  }

  void _update(String? errorMessage, bool isAuthProgress) {
    if (_errorMessage == errorMessage && _isAuthProgress == isAuthProgress) {
      return;
    }
    _errorMessage = errorMessage;
    _isAuthProgress = isAuthProgress;
    notifyListeners();
  }
}

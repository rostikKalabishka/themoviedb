import 'package:flutter/material.dart';
import 'package:themoviedb/ui/routes/routes.dart';

import '../../../domain/services/auth_service/auth_service.dart';

class LoaderViewModel {
  final AuthService _authService = AuthService();
  final BuildContext context;

  LoaderViewModel(this.context) {
    asyncInit();
  }

  Future<void> asyncInit() async {
    await checkAuth();
  }

  Future<void> checkAuth() async {
    final _isAuth = await _authService.isAuth();
    final nextScreen = _isAuth
        ? MainNavigationRouteName.mainScreen
        : MainNavigationRouteName.auth;

    Navigator.of(context).pushReplacementNamed(nextScreen);
  }
}

import 'package:flutter/material.dart';

import '../../domain/factories/screen_factory.dart';

abstract class MainNavigationRouteName {
  static const loaderScreen = '/';
  static const auth = '/auth';
  static const mainScreen = '/main_screen';
  static const movieDetails = '/main_screen/movie_details';
  static const movieTrailer = '/main_screen/movie_details/trailer';
  static const seriesTrailer = '/main_screen/series_details/trailer';
  static const seriesDetails = '/main_screen/series_details';
  static const resendEmail = 'resend_email';
  static const signUp = '/sign_up';
  static const account = '/main_screen/account';
}

class MainNavigation {
  static final _screenFactory = ScreenFactory();
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteName.loaderScreen: (_) => _screenFactory.makeLoader(),
    MainNavigationRouteName.auth: (_) => _screenFactory.makeAuth(),
    MainNavigationRouteName.mainScreen: (_) => _screenFactory.makeMainScreen(),
    MainNavigationRouteName.resendEmail: (_) =>
        _screenFactory.makeResendEmail(),
    MainNavigationRouteName.signUp: (_) => _screenFactory.makeSignUp(),
    MainNavigationRouteName.account: (_) => _screenFactory.makeAccount()
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteName.movieDetails:
        final argument = settings.arguments;
        final movieId = argument is int ? argument : 0;
        return MaterialPageRoute(
            builder: (context) => _screenFactory.makeMovieDetails(movieId));
      case MainNavigationRouteName.seriesDetails:
        final argument = settings.arguments;
        final serialId = argument is int ? argument : 0;
        return MaterialPageRoute(
          builder: (context) => _screenFactory.makeSeriesDetails(serialId),
        );
      case MainNavigationRouteName.movieTrailer:
        final argument = settings.arguments;
        final youtubeKey = argument is String ? argument : '';
        return MaterialPageRoute(
          builder: (context) =>
              _screenFactory.makeMovieTrailerWidget(youtubeKey),
        );
      case MainNavigationRouteName.seriesTrailer:
        final argument = settings.arguments;
        final youtubeKey = argument is String ? argument : '';
        return MaterialPageRoute(
          builder: (context) =>
              _screenFactory.makeSeriesTrailerWidget(youtubeKey),
        );
      default:
        const widget = Text('Navigator error');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}

// ignore_for_file: unnecessary_type_check

import 'package:flutter/material.dart';

import '../widgets/auth/auth_modal.dart';
import '../widgets/auth/auth_widget.dart';
import '../widgets/main_screen/movie_list/movie_details/movie_details.dart';
import '../widgets/main_screen/series_list/series_details/series_details.dart';
import '../widgets/signup/signup_screen.dart';
import '../widgets/main_screen/main_screen_widget.dart';
import '../widgets/resend_email/resend_email_screen.dart';

final routes = {
  '/auth': (context) => AuthProvider(
        model: AuthModel(),
        child: const AuthWidget(),
      ),
  '/main_screen': (context) => MainScreenWidget(),
  '/main_screen/movie_details': (context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as int;

    if (arguments is int) {
      return MovieDetails(
        mivieId: arguments,
      );
    } else {
      return const MovieDetails(mivieId: 0);
    }
  },
  '/main_screen/series_details': (context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as int;
    if (arguments is int) {
      return SeriesDetails(
        seriesId: arguments,
      );
    } else {
      return const SeriesDetails(seriesId: 0);
    }
  },
  '/resend_email': (context) => const ResendEmailScreen(),
  '/sign_up': (context) => const SignUpScreen()
};

abstract class MainNavigationRouteName {
  static const auth = 'auth';
  static const mainScreen = '/';
  static const movieDetails = '/movie_details';
  static const seriesDetails = '/series_details';
  static const resendEmail = 'resend_email';
  static const signUp = 'sign_up';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRouteName.mainScreen
      : MainNavigationRouteName.auth;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteName.auth: (context) => AuthProvider(
          model: AuthModel(),
          child: const AuthWidget(),
        ),
    MainNavigationRouteName.mainScreen: (context) => MainScreenWidget(),
    MainNavigationRouteName.resendEmail: (context) => const ResendEmailScreen(),
    MainNavigationRouteName.signUp: (context) => const SignUpScreen()
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteName.movieDetails:
        final argument = settings.arguments;
        final movieId = argument is int ? argument : 0;
        return MaterialPageRoute(
          builder: (context) => MovieDetails(mivieId: movieId),
        );
      case MainNavigationRouteName.seriesDetails:
        final argument = settings.arguments;
        final serialId = argument is int ? argument : 0;
        return MaterialPageRoute(
          builder: (context) => SeriesDetails(seriesId: serialId),
        );

      default:
        const widget = Text('Navigator error');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}

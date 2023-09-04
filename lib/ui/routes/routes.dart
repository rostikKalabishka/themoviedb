// ignore_for_file: unnecessary_type_check
import 'package:flutter/material.dart';
import 'package:themoviedb/ui/widgets/main_screen/account/account.dart';
import 'package:themoviedb/ui/widgets/movie_trailer/movie_trailer_widget.dart';

import '../../library/widgets/inherited/provider.dart';
import '../widgets/auth/auth_modal.dart';
import '../widgets/auth/auth_widget.dart';
import '../widgets/main_screen/main_screen_model.dart';
import '../widgets/main_screen/movie_list/movie_details/movie_details.dart';
import '../widgets/main_screen/movie_list/movie_details/movie_details_model.dart';
import '../widgets/main_screen/series_list/series_details/series_details.dart';
import '../widgets/main_screen/series_list/series_details/series_details_model.dart';
import '../widgets/signup/signup_screen.dart';
import '../widgets/main_screen/main_screen_widget.dart';
import '../widgets/resend_email/resend_email_screen.dart';

abstract class MainNavigationRouteName {
  static const auth = 'auth';
  static const mainScreen = '/';
  static const movieDetails = '/movie_details';
  static const movieTrailer = '/movie_details/trailer';
  static const seriesDetails = '/series_details';
  static const resendEmail = 'resend_email';
  static const signUp = '/sign_up';
  static const account = '/account';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRouteName.mainScreen
      : MainNavigationRouteName.auth;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteName.auth: (context) => NotifierProvider(
          create: () => AuthModel(),
          child: const AuthWidget(),
        ),
    MainNavigationRouteName.mainScreen: (context) => NotifierProvider(
        create: () => MainScreenModel(), child: MainScreenWidget()),
    MainNavigationRouteName.resendEmail: (context) => const ResendEmailScreen(),
    MainNavigationRouteName.signUp: (context) => const SignUpScreen(),
    MainNavigationRouteName.account: (context) => const Account()
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteName.movieDetails:
        final argument = settings.arguments;
        final movieId = argument is int ? argument : 0;
        return MaterialPageRoute(
          builder: (context) => NotifierProvider(
              create: () => MovieDetailsModel(movieId),
              child: const MovieDetails()),
        );
      case MainNavigationRouteName.seriesDetails:
        final argument = settings.arguments;
        final serialId = argument is int ? argument : 0;
        return MaterialPageRoute(
          builder: (context) => NotifierProvider(
              create: () => SeriesDetailsModel(serialId),
              child: const SeriesDetails()),
        );
      case MainNavigationRouteName.movieTrailer:
        final argument = settings.arguments;
        final youtubeKey = argument is String ? argument : '';
        return MaterialPageRoute(
          builder: (context) => MovieTrailerWidget(youtubeKey: youtubeKey),
        );
      default:
        const widget = Text('Navigator error');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}

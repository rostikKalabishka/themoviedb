import 'package:flutter/material.dart';

import '../widgets/auth/auth_widget.dart';
import '../widgets/main_screen/movie_list/movie_details/movie_details.dart';
import '../widgets/main_screen/series_list/series_details/series_details.dart';
import '../widgets/signup/signup_screen.dart';
import '../widgets/main_screen/main_screen_widget.dart';
import '../widgets/resend_email/resend_email_screen.dart';

final routes = {
  '/auth': (context) => AuthWidget(),
  '/main_screen': (context) => MainScreenWidget(),
  '/main_screen/movie_details': (context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as int;
    if (arguments is int) {
      return MovieDetails(
        mivieId: arguments,
      );
    } else {
      return SeriesDetails(seriesId: 0);
    }
  },
  '/main_screen/series_details': (context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as int;
    if (arguments is int) {
      return SeriesDetails(
        seriesId: arguments,
      );
    } else {
      return SeriesDetails(seriesId: 0);
    }
  },
  '/resend_email': (context) => ResendEmailScreen(),
  '/sign_up': (context) => SignUpScreen()
};

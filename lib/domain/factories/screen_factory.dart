import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/domain/blocs/auth_bloc.dart';

import 'package:themoviedb/ui/widgets/loader/loader_view_model.dart';
import 'package:themoviedb/ui/widgets/loader/loader_widget.dart';
import 'package:themoviedb/ui/widgets/main_screen/account/account.dart';
import 'package:themoviedb/ui/widgets/main_screen/account/account_model.dart';

import '../../ui/widgets/auth/auth_modal.dart';
import '../../ui/widgets/auth/auth_widget.dart';

import '../../ui/widgets/main_screen/home_page/home_page_widget.dart';
import '../../ui/widgets/main_screen/home_page/home_page_widget_model.dart';
import '../../ui/widgets/main_screen/main_screen_widget.dart';
import '../../ui/widgets/main_screen/movie_list/movie_details/movie_details.dart';
import '../../ui/widgets/main_screen/movie_list/movie_details/movie_details_model.dart';
import '../../ui/widgets/main_screen/movie_list/movie_list_model.dart';
import '../../ui/widgets/main_screen/movie_list/movie_list_widget.dart';
import '../../ui/widgets/main_screen/series_list/series_details/series_details.dart';
import '../../ui/widgets/main_screen/series_list/series_details/series_details_model.dart';
import '../../ui/widgets/main_screen/series_list/series_list_model.dart';
import '../../ui/widgets/main_screen/series_list/series_list_widget.dart';
import '../../ui/widgets/movie_trailer/movie_trailer_widget.dart';
import '../../ui/widgets/resend_email/resend_email_screen.dart';
import '../../ui/widgets/series_trailer/series_trailer.dart';
import '../../ui/widgets/signup/signup_screen.dart';

class ScreenFactory {
  AuthBloc? _authBloc;
  Widget makeLoader() {
    final authBloc = _authBloc ?? AuthBloc(AuthCheckInProgressState());
    _authBloc = authBloc;
    return BlocProvider<LoaderViewCubit>(
      create: (context) =>
          LoaderViewCubit(LoaderViewCubitState.unknown, authBloc),
      lazy: false,
      child: const LoaderWidget(),
    );
  }

  Widget makeAuth() {
    return ChangeNotifierProvider(
      create: (_) => AuthModel(),
      child: const AuthWidget(),
    );
  }

  Widget makeMainScreen() {
    return const MainScreenWidget();
  }

  Widget makeResendEmail() {
    return const ResendEmailScreen();
  }

  Widget makeSignUp() {
    return const SignUpScreen();
  }

  Widget makeAccount() {
    return ChangeNotifierProvider(
      create: (_) => AccountModel(),
      child: const Account(),
    );
  }

  Widget makeMovieDetails(int movieId) {
    return ChangeNotifierProvider(
      create: (_) => MovieDetailsModel(movieId),
      child: const MovieDetails(),
    );
  }

  Widget makeSeriesDetails(int serialId) {
    return ChangeNotifierProvider(
        create: (_) => SeriesDetailsModel(serialId),
        child: const SeriesDetails());
  }

  Widget makeMovieTrailerWidget(String youtubeKey) {
    return MovieTrailerWidget(youtubeKey: youtubeKey);
  }

  Widget makeSeriesTrailerWidget(String youtubeKey) {
    return SeriesTrailerWidget(youtubeKey: youtubeKey);
  }

  Widget makeHomePage() {
    return ChangeNotifierProvider(
      create: (_) => HomePageWidgetModel(),
      child: const HomePageWidget(),
    );
  }

  Widget makeMovieList() {
    return ChangeNotifierProvider(
      create: (_) => MovieListModel(),
      child: const MovieListWidget(),
    );
  }

  Widget makeSeriesList() {
    return ChangeNotifierProvider(
      create: (_) => SeriesListModel(),
      child: const SeriesListWidget(),
    );
  }
}

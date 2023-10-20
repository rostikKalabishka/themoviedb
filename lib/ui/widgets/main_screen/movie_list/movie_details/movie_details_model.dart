import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/account_api_client/account_api_client.dart';
import 'package:themoviedb/domain/api_client/movie_api_client/movie_api_client.dart';

import '../../../../../domain/api_client/api_client_exaption.dart';
import '../../../../../domain/api_client/data_providers/session_data_provider.dart';
import '../../../../../domain/entity/movie/movie_details/movie_details.dart';
import '../../../../../domain/entity/movie/movie_details_rec/movie_details_rec.dart';
import '../../../../routes/routes.dart';

class MovieDetailsModel extends ChangeNotifier {
  final _movieApiClient = MovieApiClient();
  final _accountApiClient = AccountApiClient();

  final int movieId;
  MovieDetails? _movieDetails;
  MovieDetailsRec? _movieDetailsRec;
  String _locale = '';
  bool _isFavorite = false;
  final _sessionDataProvide = SessionDataProvider();
  late DateFormat _dateFormat;
  late String _errorMessage;
  Future<void>? Function()? onSessionExpired;

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  MovieDetails? get movieDetails => _movieDetails;
  MovieDetailsRec? get movieDetailRec => _movieDetailsRec;
  String? get errorMessage => _errorMessage;
  bool get isFavorite => _isFavorite;

  MovieDetailsModel(
    this.movieId,
  );

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMEd(locale);
    await _loadDetails();
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _movieDetailsRec?.movieRec[index].id;
    Navigator.of(context)
        .pushNamed(MainNavigationRouteName.movieDetails, arguments: id);
  }

  Future<void> _loadDetails() async {
    try {
      final sessionId = await _sessionDataProvide.getSessionId();
      _movieDetails = await _movieApiClient.movieDetails(movieId, _locale);
      _movieDetailsRec =
          await _movieApiClient.movieDetailsRec(movieId, _locale);
      if (sessionId != null) {
        _isFavorite = await _movieApiClient.isFavorite(movieId, sessionId);
      }

      notifyListeners();
    } on ApiClientException catch (e) {
      _handleApiClientException(e);
    }
  }

  void navigateYoutubeVideos(BuildContext context, String trailerKey) {
    Navigator.of(context)
        .pushNamed(MainNavigationRouteName.movieTrailer, arguments: trailerKey);
  }

  Future<void> toggleFavorite() async {
    final accountId = await _sessionDataProvide.getAccountId();
    final sessionId = await _sessionDataProvide.getSessionId();

    if (accountId == null || sessionId == null) return;

    _isFavorite = !_isFavorite;

    notifyListeners();

    try {
      await _accountApiClient.addFavorite(
          accountId: accountId,
          sessionId: sessionId,
          mediaType: ApiClientMediaType.movie,
          mediaId: movieId,
          isFavorite: _isFavorite);
    } on ApiClientException catch (e) {
      _handleApiClientException(e);
    }
  }

  void _handleApiClientException(ApiClientException exeption) {
    switch (exeption.type) {
      case ApiClientExceptionType.SessionExpired:
        onSessionExpired?.call();
        break;
      default:
        print(exeption);
    }
  }
}

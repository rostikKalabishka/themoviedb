import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';

import '../../../../../domain/api_client/data_providers/session_data_provider.dart';
import '../../../../../domain/entity/movie/movie_details/movie_details.dart';
import '../../../../../domain/entity/movie/movie_details_rec/movie_details_rec.dart';
import '../../../../routes/routes.dart';

class MovieDetailsModel extends ChangeNotifier {
  final _apiClient = ApiClient();

  final int movieId;
  MovieDetails? _movieDetails;
  MovieDetailsRec? _movieDetailsRec;
  String _locale = '';
  bool _isFavorite = false;
  final _sessionDataProvide = SessionDataProvider();
  late DateFormat _dateFormat;

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  MovieDetails? get movieDetails => _movieDetails;
  MovieDetailsRec? get movieDetailRec => _movieDetailsRec;
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
    final sessionId = await _sessionDataProvide.getSessionId();
    _movieDetails = await _apiClient.movieDetails(movieId, _locale);
    _movieDetailsRec = await _apiClient.movieDetailsRec(movieId, _locale);
    if (sessionId != null) {
      _isFavorite = await _apiClient.isFavorite(movieId, sessionId);
    }

    notifyListeners();
  }

  Future<void> toggleFavorite() async {
    final accountId = await _sessionDataProvide.getAccountId();
    final sessionId = await _sessionDataProvide.getSessionId();

    if (accountId == null || sessionId == null) return;

    _isFavorite = !_isFavorite;

    notifyListeners();
    await _apiClient.addFavorite(
        accountId: accountId,
        sessionId: sessionId,
        mediaType: ApiClientMediaType.Movie,
        mediaId: movieId,
        isFavorite: _isFavorite);
  }
}

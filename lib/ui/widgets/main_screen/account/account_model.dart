import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../domain/api_client/account_api_client/account_api_client.dart';
// import '../../../../domain/api_client/auth_api_client/auth_api_client.dart';
import '../../../../domain/api_client/data_providers/session_data_provider.dart';
import '../../../../domain/api_client/movie_api_client/movie_api_client.dart';
import '../../../../domain/api_client/series_api_client/series_api_client.dart';
import '../../../../domain/entity/account/account_details.dart';
import '../../../../domain/entity/movie/favorite_movie/favorite_movie.dart';
import '../../../../domain/entity/series/favorite_series/favorite_series.dart';
import '../../../routes/routes.dart';

class AccountModel extends ChangeNotifier {
  final _accountClient = AccountApiClient();
  final _movieClient = MovieApiClient();
  final _seriesClient = SeriesApiClient();
  // final _authClient = AuthApiClient();

  final _sessionDataProvider = SessionDataProvider();

  late int movieId;
  AccountDetails? _accountDetails;

  MovieFavorite? _favoriteMovie;
  FavoriteSeries? _favoriteSeries;
  String _locale = '';
  late DateFormat _dateFormat;

  AccountDetails? get accountDetails => _accountDetails;
  MovieFavorite? get favoriteMovie => _favoriteMovie;
  FavoriteSeries? get favoriteSeries => _favoriteSeries;

  AccountModel();

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMEd(locale);
    await _loadDetails();
    await _loadFavoriteMovie();
  }

  Future<void> _loadFavoriteMovie() async {
    final accountId = await _sessionDataProvider.getAccountId();
    final sessionId = await _sessionDataProvider.getSessionId();

    if (accountId == null || sessionId == null) return;
    _favoriteMovie =
        await _movieClient.favoriteMovie(accountId, _locale, 1, sessionId);
    _favoriteSeries =
        await _seriesClient.favoriteSeries(accountId, _locale, 1, sessionId);

    notifyListeners();
  }

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  void onMovieTap(BuildContext context, int index) {
    if (_favoriteMovie != null) {
      final id = _favoriteMovie?.results[index].id;
      Navigator.of(context)
          .pushNamed(MainNavigationRouteName.movieDetails, arguments: id);
    }
  }

  void onSeriesTap(BuildContext context, int index) {
    if (_favoriteMovie != null) {
      final id = _favoriteSeries?.results[index].id;
      Navigator.of(context)
          .pushNamed(MainNavigationRouteName.seriesDetails, arguments: id);
    }
  }

  Future<void> _loadDetails() async {
    final accountId = await _sessionDataProvider.getAccountId();
    final sessionId = await _sessionDataProvider.getSessionId();

    if (accountId == null || sessionId == null) return;

    _accountDetails = await _accountClient.accountDetails(sessionId, accountId);

    notifyListeners();
  }

  Future<void> deleteSession(BuildContext context) async {
    final sessionId = await _sessionDataProvider.getSessionId();
    if (sessionId == null) return;
    // final sessionIdDelete = await _authClient.deleteSession(sessionId);
    _sessionDataProvider.deleteSessionId();
    Navigator.of(context).pushNamed(MainNavigationRouteName.auth);
  }
}

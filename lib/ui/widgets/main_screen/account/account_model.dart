import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';

import '../../../../domain/api_client/data_providers/session_data_provider.dart';
import '../../../../domain/entity/account_details.dart';
import '../../../../domain/entity/favorite_movie.dart';
import '../../../routes/routes.dart';

class AccountModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();
  late int movieId;
  AccountDetails? _accountDetails;
// String? sessionId;
  MovieFavorite? _favoriteMovie;
  String _locale = '';
  late DateFormat _dateFormat;

  AccountDetails? get accountDetails => _accountDetails;
  MovieFavorite? get favoriteMovie => _favoriteMovie;

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
        await _apiClient.favoriteMovie(accountId, _locale, 1, sessionId);

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

  Future<void> _loadDetails() async {
    final accountId = await _sessionDataProvider.getAccountId();
    final sessionId = await _sessionDataProvider.getSessionId();

    if (accountId == null || sessionId == null) return;

    _accountDetails = await _apiClient.accountDetails(sessionId, accountId);

    notifyListeners();
  }

  Future<void> deleteSession(BuildContext context) async {
    final sessionId = await _sessionDataProvider.getSessionId();
    if (sessionId == null) return;
    final sessionIdDelete = await _apiClient.deleteSession(sessionId);
    _sessionDataProvider.setSessionId(sessionIdDelete);
    Navigator.of(context).pushNamed(MainNavigationRouteName.auth);
  }
}

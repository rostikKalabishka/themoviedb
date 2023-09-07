import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';

import '../../../../../domain/api_client/data_providers/session_data_provider.dart';
import '../../../../../domain/entity/series/series_details/series_details.dart';
import '../../../../../domain/entity/series/series_details_rec/series_details_rec.dart';
import '../../../../routes/routes.dart';

class SeriesDetailsModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final int seriesId;
  SeriesDetails? _seriesDetails;
  String _locale = '';
  bool _isFavorite = false;
  late DateFormat _dateFormat;
  final _sessionDataProvide = SessionDataProvider();
  SeriesDetailsRec? _seriesDetailsRec;
  Future<void>? Function()? onSessionExpired;

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  SeriesDetails? get seriesDetails => _seriesDetails;
  SeriesDetailsRec? get seriesDetailsRec => _seriesDetailsRec;
  bool get isFavorite => _isFavorite;

  SeriesDetailsModel(this.seriesId);

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMEd(locale);
    await _loadDetails();
  }

  Future<void> _loadDetails() async {
    final sessionId = await _sessionDataProvide.getSessionId();
    _seriesDetails = await _apiClient.seriesDetails(seriesId, _locale);
    _seriesDetailsRec = await _apiClient.seriesDetailsRec(seriesId, _locale);

    if (sessionId != null) {
      _isFavorite = await _apiClient.isFavoriteSeries(seriesId, sessionId);
    }

    notifyListeners();
  }

  void navigateYoutubeVideos(BuildContext context, String trailerKey) {
    Navigator.of(context).pushNamed(MainNavigationRouteName.seriesTrailer,
        arguments: trailerKey);
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _seriesDetailsRec?.seriesRec[index].id;
    Navigator.of(context)
        .pushNamed(MainNavigationRouteName.seriesDetails, arguments: id);
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
        mediaType: ApiClientMediaType.TV,
        mediaId: seriesId,
        isFavorite: _isFavorite);
  }

  void _handleApiClientException(ApiClientException exeption) {
    switch (exeption.type) {
      case ApiClientExceptionType.SessionExpired:
        // onSessionExpired?.call();
        break;
      default:
        print(exeption);
    }
  }
}

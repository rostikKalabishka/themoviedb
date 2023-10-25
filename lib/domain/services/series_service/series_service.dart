import '../../../config/config.dart';
import '../../api_client/account_api_client/account_api_client.dart';
import '../../api_client/data_providers/session_data_provider.dart';
import '../../api_client/series_api_client/series_api_client.dart';
import '../../entity/series/popular_series_response/popular_series_response.dart';
import '../../entity/series/series_details_rec/series_details_rec.dart';
import '../../local_entity/series_details_local_entity.dart';

class SeriesService {
  final SeriesApiClient _seriesApiClient = SeriesApiClient();
  final _sessionDataProvide = SessionDataProvider();
  final _accountApiClient = AccountApiClient();
  Future<PopularSeriesResponse> popularSeries(
    int page,
    String locale,
  ) async {
    return await _seriesApiClient.popularSeries(
        page, locale, Configuration.apiKey);
  }

  Future<PopularSeriesResponse> searchSeries(
      int page, String locale, String query) async {
    return await _seriesApiClient.searchSeries(
        page, locale, query, Configuration.apiKey);
  }

  Future<SeriesDetailLocalEntity> loadDetails(
      {required int seriesId, required String locale}) async {
    final sessionId = await _sessionDataProvide.getSessionId();
    final seriesDetails =
        await _seriesApiClient.seriesDetails(seriesId, locale);
    var isFavorite = false;

    if (sessionId != null) {
      isFavorite = await _seriesApiClient.isFavoriteSeries(seriesId, sessionId);
    }

    return SeriesDetailLocalEntity(
        details: seriesDetails, isFavorite: isFavorite);
  }

  Future<SeriesDetailsRec> seriesRec(
      {required int seriesId, required String locale}) async {
    return await _seriesApiClient.seriesDetailsRec(seriesId, locale);
  }

  Future<void> updateFavorite(
      {required bool isFavorite, required int seriesId}) async {
    final accountId = await _sessionDataProvide.getAccountId();
    final sessionId = await _sessionDataProvide.getSessionId();

    if (accountId == null || sessionId == null) return;

    await _accountApiClient.addFavorite(
        accountId: accountId,
        sessionId: sessionId,
        mediaType: ApiClientMediaType.tv,
        mediaId: seriesId,
        isFavorite: isFavorite);
  }
}

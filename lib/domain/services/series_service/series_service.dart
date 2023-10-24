import '../../../config/config.dart';
// import '../../api_client/account_api_client/account_api_client.dart';
// import '../../api_client/data_providers/session_data_provider.dart';
import '../../api_client/series_api_client/series_api_client.dart';
import '../../entity/series/popular_series_response/popular_series_response.dart';

class SeriesService {
  final SeriesApiClient _seriesApiClient = SeriesApiClient();
  // final _sessionDataProvide = SessionDataProvider();
  // final _accountApiClient = AccountApiClient();
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
}

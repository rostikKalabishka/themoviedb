import '../../../config/config.dart';

import '../../entity/series/favorite_series/favorite_series.dart';
import '../../entity/series/popular_series_response/popular_series_response.dart';
import '../../entity/series/series_details/series_details.dart';
import '../../entity/series/series_details_rec/series_details_rec.dart';
import '../network_client.dart';

class SeriesApiClient {
  final _networkClient = NetworkClient();

  Future<PopularSeriesResponse> popularSeries(
      int page, String locale, String apiKey) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularSeriesResponse.fromJson(jsonMap);

      return response;
    }

    final result = _networkClient.get(
        '${Configuration.host}/tv/popular', parser, <String, dynamic>{
      'api_key': apiKey,
      'language': locale,
      'page': page.toString()
    });

    return result;
  }

  Future<PopularSeriesResponse> searchSeries(
      int page, String locale, String query, String apiKey) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularSeriesResponse.fromJson(jsonMap);

      return response;
    }

    final result = _networkClient
        .get('${Configuration.host}/search/tv', parser, <String, dynamic>{
      'api_key': apiKey,
      'language': locale,
      'page': page.toString(),
      'query': query,
      'include_adult': true.toString(),
    });
    return result;
  }

  Future<FavoriteSeries> favoriteSeries(
    int accountId,
    String locale,
    int page,
    String sessionId,
  ) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = FavoriteSeries.fromJson(jsonMap);

      return response;
    }

    final result = _networkClient.get(
        '${Configuration.host}/account/$accountId/favorite/tv',
        parser, <String, dynamic>{
      'api_key': Configuration.apiKey,
      'language': locale,
      'page': page.toString(),
      'session_id': sessionId,
      'sort_by': 'created_at.asc'
    });
    return result;
  }

  Future<SeriesDetailsRec> seriesDetailsRec(
    int seriesId,
    String locale,
  ) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = SeriesDetailsRec.fromJson(jsonMap);

      return response;
    }

    final result = _networkClient.get(
        '${Configuration.host}/tv/$seriesId/recommendations',
        parser, <String, dynamic>{
      'api_key': Configuration.apiKey,
      'language': locale,
      'series_id': seriesId.toString(),
    });
    return result;
  }

  Future<SeriesDetails> seriesDetails(
    int seriesId,
    String locale,
  ) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = SeriesDetails.fromJson(jsonMap);

      return response;
    }

    final result = _networkClient
        .get('${Configuration.host}/tv/$seriesId', parser, <String, dynamic>{
      'append_to_response': 'videos,credits',
      'api_key': Configuration.apiKey,
      'language': locale,
    });
    return result;
  }

  Future<bool> isFavoriteSeries(
    int seriesId,
    String sessionId,
  ) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = jsonMap['favorite'] as bool;

      return result;
    }

    final result = _networkClient.get(
        '${Configuration.host}/tv/$seriesId/account_states',
        parser, <String, dynamic>{
      'api_key': Configuration.apiKey,
      'session_id': sessionId,
    });
    return result;
  }
}

import '../../../config/config.dart';
import '../../entity/account/account_details.dart';
import '../network_client.dart';

enum ApiClientMediaType { movie, tv }

extension ApiClientMediaTypeAsString on ApiClientMediaType {
  String asString() {
    switch (this) {
      case ApiClientMediaType.movie:
        return 'movie';
      case ApiClientMediaType.tv:
        return 'tv';
    }
  }
}

class AccountApiClient {
  final _networkClient = NetworkClient();

  Future<int> getAccountInfo(
    String sessionId,
  ) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = jsonMap['id'] as int;

      return result;
    }

    final result = _networkClient
        .get('${Configuration.host}/account', parser, <String, dynamic>{
      'api_key': Configuration.apiKey,
      'session_id': sessionId,
    });
    return result;
  }

  Future<AccountDetails> accountDetails(
    String sessionId,
    int accountId,
  ) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;

      final response = AccountDetails.fromJson(jsonMap);

      return response;
    }

    final result = _networkClient.get(
        '${Configuration.host}/account/$accountId', parser, <String, dynamic>{
      'api_key': Configuration.apiKey,
      'session_id': sessionId,
    });
    return result;
  }

  Future<int> addFavorite({
    required int accountId,
    required String sessionId,
    required ApiClientMediaType mediaType,
    required int mediaId,
    required bool isFavorite,
  }) async {
    final parameters = <String, dynamic>{
      'media_type': mediaType.asString(),
      'media_id': mediaId,
      'favorite': isFavorite
    };
    parser(dynamic json) {
      return 1;
    }

    final result = _networkClient.post(
        '${Configuration.host}/account/$accountId/favorite',
        parameters,
        parser, <String, dynamic>{
      'api_key': Configuration.apiKey,
      'session_id': sessionId,
    });

    return result;
  }
}

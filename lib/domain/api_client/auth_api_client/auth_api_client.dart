import '../../../config/config.dart';
import '../network_client.dart';

class AuthApiClient {
  final _networkClient = NetworkClient();
  Future<String> auth({
    required String username,
    required String password,
  }) async {
    final token = await _makeToken();
    final validToken = await _validateUser(
      username: username,
      password: password,
      requestToken: token,
    );
    final sessionId = await _makeSession(requestToken: validToken);
    return sessionId;
  }

  Future<String> _makeToken() async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final result = _networkClient.get(
        '${Configuration.host}/authentication/token/new',
        parser,
        <String, dynamic>{'api_key': Configuration.apiKey});
    return result;
  }

  Future<String> _validateUser({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final parameters = <String, dynamic>{
      'username': username,
      'password': password,
      'request_token': requestToken,
    };
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final result = _networkClient.post(
        '${Configuration.host}/authentication/token/validate_with_login',
        parameters,
        parser,
        <String, dynamic>{'api_key': Configuration.apiKey});

    return result;
  }

//_makeSession
  Future<String> _makeSession({
    required String requestToken,
  }) async {
    final parameters = <String, dynamic>{
      'request_token': requestToken,
    };
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final sessionId = jsonMap['session_id'] as String;
      return sessionId;
    }

    final result = _networkClient.post('/authentication/session/new',
        parameters, parser, <String, dynamic>{'api_key': Configuration.apiKey});

    return result;
  }

  Future<Null> deleteSession(
    String sessionId,
  ) async {
    final parameters = <String, dynamic>{
      'session_id': sessionId,
    };
    parser(dynamic json) {
      return null;
    }

    final result = _networkClient.delete(
        '${Configuration.host}/authentication/session',
        parameters,
        parser,
        <String, dynamic>{'api_key': Configuration.apiKey});
    return result;
  }
}

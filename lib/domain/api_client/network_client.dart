import 'dart:convert';
import 'dart:io';

import '../../config/config.dart';
import 'api_client_exaption.dart';

class NetworkClient {
  final _client = HttpClient();

  static String imageUrl(String path) {
    return Configuration.imageUrl + path;
  }

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse(path);
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<T> get<T>(String path, T Function(dynamic json) parser,
      [Map<String, dynamic>? parameters]) async {
    final url = _makeUri(
      path,
      parameters,
    );
    try {
      final request = await _client.getUrl(url);
      final response = await request.close();

      final dynamic json = (await response.jsonDecode());
      _validateResponse(response, json);
      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (e) {
      throw ApiClientException(ApiClientExceptionType.Other);
    }
  }

  Future<T> delete<T>(
    String path,
    Map<String, dynamic> bodyParameters,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? urlParameters,
  ]) async {
    try {
      final url = _makeUri(
        path,
        urlParameters,
      );

      final request = await _client.postUrl(url);

      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(bodyParameters));
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());
      _validateResponse(response, json);

      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.Other);
    }
  }

  Future<T> post<T>(
    String path,
    Map<String, dynamic> bodyParameters,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? urlParameters,
  ]) async {
    try {
      final url = _makeUri(
        path,
        urlParameters,
      );

      final request = await _client.postUrl(url);

      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(bodyParameters));
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());
      _validateResponse(response, json);

      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.Other);
    }
  }

  void _validateResponse(HttpClientResponse response, dynamic json) {
    if (response.statusCode == 401) {
      final dynamic status = json['status_code'];
      final code = status is int ? status : 0;
      if (code == 30) {
        throw ApiClientException(ApiClientExceptionType.Auth);
      } else if (code == 3) {
        throw ApiClientException(ApiClientExceptionType.SessionExpired);
      } else {
        throw ApiClientException(ApiClientExceptionType.Other);
      }
    }
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then<dynamic>((v) => json.decode(v));
  }
}

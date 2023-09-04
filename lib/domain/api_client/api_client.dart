import 'dart:convert';
import 'dart:io';

import 'package:themoviedb/domain/entity/popular_series_response.dart';

import '../entity/movie_details.dart';
import '../entity/movie_details_rec.dart';
import '../entity/popular_movie_response.dart';
import '../entity/series_details.dart';
import '../static_const_url_client.dart';

// ignore: constant_identifier_names
enum ApiClientExceptionType { Network, Auth, Other }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

enum ApiClientMediaType { Movie, TV }

extension ApiClientMediaTypeAsString on ApiClientMediaType {
  String asString() {
    switch (this) {
      case ApiClientMediaType.Movie:
        return 'movie';
      case ApiClientMediaType.TV:
        return 'movie';
    }
  }
}

class ApiClient {
  final _client = HttpClient();

  static const _host = StaticConstUrlClient.host;
  static const _imageUrl = StaticConstUrlClient.imageUrl;
  static const _apiKey = StaticConstUrlClient.apiKey;

  static String imageUrl(String path) {
    return _imageUrl + path;
  }

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

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$_host$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<T> _get<T>(String path, T Function(dynamic json) parser,
      [Map<String, dynamic>? parameters]) async {
    final url = _makeUri(
      path,
      parameters,
    );
    try {
      final request = await _client.getUrl(url);
      final response = await request.close();
      if (response.statusCode == 201) {
        return 1 as T;
      }
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

  Future<T> _post<T>(
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

  Future<String> _makeToken() async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final result = _get('/authentication/token/new', parser,
        <String, dynamic>{'api_key': _apiKey});
    return result;
  }

  Future<int> getAccountInfo(
    String sessionId,
  ) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = jsonMap['id'] as int;

      return result;
    }

    final result = _get('/account', parser, <String, dynamic>{
      'api_key': _apiKey,
      'session_id': sessionId,

      // 'movie_id': movieId.toString(),
    });
    return result;
  }

//MOVIE
  Future<PopularMovieResponse> popularMovie(int page, String locale) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);

      return response;
    }

    final result = _get('/movie/popular', parser, <String, dynamic>{
      'api_key': _apiKey,
      'language': locale,
      'page': page.toString()
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

    final result = _post(
        '/account/$accountId/favorite', parameters, parser, <String, dynamic>{
      'api_key': _apiKey,
      'session_id': sessionId,
    });

    return result;
  }

  Future<PopularMovieResponse> searchMovie(
      int page, String locale, String query) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);

      return response;
    }

    final result = _get('/search/movie', parser, <String, dynamic>{
      'api_key': _apiKey,
      'language': locale,
      'page': page.toString(),
      'query': query,
      'include_adult': true.toString(),
    });
    return result;
  }

  Future<MovieDetails> movieDetails(
    int movieId,
    String locale,
  ) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieDetails.fromJson(jsonMap);

      return response;
    }

    final result = _get('/movie/$movieId', parser, <String, dynamic>{
      'append_to_response': 'credits,videos',
      'api_key': _apiKey,
      'language': locale,
      // 'movie_id': movieId.toString(),
    });
    return result;
  }

  Future<bool> isFavorite(
    int movieId,
    String sessionId,
  ) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = jsonMap['favorite'] as bool;

      return result;
    }

    final result =
        _get('/movie/$movieId/account_states', parser, <String, dynamic>{
      'api_key': _apiKey,
      'session_id': sessionId,

      // 'movie_id': movieId.toString(),
    });
    return result;
  }

  Future<MovieDetailsRec> movieDetailsRec(
    int movieId,
    String locale,
  ) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieDetailsRec.fromJson(jsonMap);

      return response;
    }

    final result =
        _get('/movie/$movieId/recommendations', parser, <String, dynamic>{
      'api_key': _apiKey,
      'language': locale,
      'movie_id': movieId.toString(),
    });
    return result;
  }

//SERIES

  Future<PopularSeriesResponse> popularSeries(int page, String locale) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularSeriesResponse.fromJson(jsonMap);

      return response;
    }

    final result = _get('/tv/popular', parser, <String, dynamic>{
      'api_key': _apiKey,
      'language': locale,
      'page': page.toString()
    });

    return result;
  }

  Future<PopularSeriesResponse> searchSeries(
      int page, String locale, String query) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularSeriesResponse.fromJson(jsonMap);

      return response;
    }

    final result = _get('/search/tv', parser, <String, dynamic>{
      'api_key': _apiKey,
      'language': locale,
      'page': page.toString(),
      'query': query,
      'include_adult': true.toString(),
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

    final result = _get('/tv/$seriesId', parser, <String, dynamic>{
      'api_key': _apiKey,
      'language': locale,
      'series_id': seriesId.toString(),
    });
    return result;
  }

//_validateUser
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

    final result = _post('/authentication/token/validate_with_login',
        parameters, parser, <String, dynamic>{'api_key': _apiKey});

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

    final result = _post('/authentication/session/new', parameters, parser,
        <String, dynamic>{'api_key': _apiKey});

    return result;
  }

//_validateResponse
  void _validateResponse(HttpClientResponse response, dynamic json) {
    if (response.statusCode == 401) {
      final dynamic status = json['status_code'];
      final code = status is int ? status : 0;
      if (code == 30) {
        throw ApiClientException(ApiClientExceptionType.Auth);
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

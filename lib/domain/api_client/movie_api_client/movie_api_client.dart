import 'package:themoviedb/config/config.dart';
import '../../entity/movie/favorite_movie/favorite_movie.dart';
import '../../entity/movie/movie_details/movie_details.dart';
import '../../entity/movie/movie_details_rec/movie_details_rec.dart';
import '../../entity/movie/popular_movie_response/popular_movie_response.dart';

import '../network_client.dart';

class MovieApiClient {
  final _networkClient = NetworkClient();

  Future<PopularMovieResponse> popularMovie(
      int page, String locale, String apiKey) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);

      return response;
    }

    final result = _networkClient.get(
        '${Configuration.host}/movie/popular', parser, <String, dynamic>{
      'api_key': Configuration.apiKey,
      'language': locale,
      'page': page.toString()
    });
    return result;
  }

  Future<MovieFavorite> favoriteMovie(
    int accountId,
    String locale,
    int page,
    String sessionId,
  ) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieFavorite.fromJson(jsonMap);

      return response;
    }

    final result = _networkClient.get(
        '${Configuration.host}/account/$accountId/favorite/movies',
        parser, <String, dynamic>{
      'api_key': Configuration.apiKey,
      'language': locale,
      'page': page.toString(),
      'session_id': sessionId,
      'sort_by': 'created_at.asc'
    });
    return result;
  }

  Future<PopularMovieResponse> searchMovie(
      int page, String locale, String query, String apiKey) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);

      return response;
    }

    final result = _networkClient
        .get('${Configuration.host}/search/movie', parser, <String, dynamic>{
      'api_key': apiKey,
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

    final result = _networkClient
        .get('${Configuration.host}/movie/$movieId', parser, <String, dynamic>{
      'append_to_response': 'credits,videos',
      'api_key': Configuration.apiKey,
      'language': locale,
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

    final result = _networkClient.get(
        '${Configuration.host}/movie/$movieId/account_states',
        parser, <String, dynamic>{
      'api_key': Configuration.apiKey,
      'session_id': sessionId,
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

    final result = _networkClient.get(
        '${Configuration.host}/movie/$movieId/recommendations',
        parser, <String, dynamic>{
      'api_key': Configuration.apiKey,
      'language': locale,
      'movie_id': movieId.toString(),
    });
    return result;
  }
}

import 'package:themoviedb/config/config.dart';

import '../../api_client/movie_api_client/movie_api_client.dart';
import '../../entity/movie/popular_movie_response/popular_movie_response.dart';

class MovieService {
  final _movieApiClient = MovieApiClient();
  Future<PopularMovieResponse> popularMovie(
    int page,
    String locale,
  ) async {
    return await _movieApiClient.popularMovie(
        page, locale, Configuration.apiKey);
  }

  Future<PopularMovieResponse> searchMovie(
      int page, String locale, String query) async {
    return await _movieApiClient.searchMovie(
        page, locale, query, Configuration.apiKey);
  }
}

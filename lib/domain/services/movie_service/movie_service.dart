import 'package:themoviedb/config/config.dart';
import '../../api_client/account_api_client/account_api_client.dart';
import '../../api_client/data_providers/session_data_provider.dart';
import '../../api_client/movie_api_client/movie_api_client.dart';
import '../../entity/movie/movie_details_rec/movie_details_rec.dart';
import '../../entity/movie/popular_movie_response/popular_movie_response.dart';
import '../../local_entity/movie_details_local_entity.dart';

class MovieService {
  final _movieApiClient = MovieApiClient();

  final _sessionDataProvide = SessionDataProvider();
  final _accountApiClient = AccountApiClient();
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

  Future<MovieDetailLocalEntity> loadDetails(
      {required int movieId, required String locale}) async {
    final sessionId = await _sessionDataProvide.getSessionId();
    final movieDetails = await _movieApiClient.movieDetails(movieId, locale);
    var isFavorite = false;

    // await _movieApiClient.movieDetailsRec(movieId, locale);
    if (sessionId != null) {
      isFavorite = await _movieApiClient.isFavorite(movieId, sessionId);
    }

    return MovieDetailLocalEntity(
        details: movieDetails, isFavorite: isFavorite);
  }

  Future<MovieDetailsRec> movieRec(
      {required int movieId, required String locale}) async {
    return await _movieApiClient.movieDetailsRec(movieId, locale);
  }

  Future<void> updateFavorite(
      {required bool isFavorite, required int movieId}) async {
    final accountId = await _sessionDataProvide.getAccountId();
    final sessionId = await _sessionDataProvide.getSessionId();

    if (accountId == null || sessionId == null) return;

    await _accountApiClient.addFavorite(
        accountId: accountId,
        sessionId: sessionId,
        mediaType: ApiClientMediaType.movie,
        mediaId: movieId,
        isFavorite: isFavorite);
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../domain/api_client/series_api_client/series_api_client.dart';
import '../../../../domain/entity/movie/popular_movie_response/popular_movie_response.dart';
import '../../../../domain/entity/series/popular_series_response/popular_series_response.dart';
import '../../../../domain/services/movie_service/movie_service.dart';
import '../../../routes/routes.dart';

class HomePageWidgetModel extends ChangeNotifier {
  final _movieApiClient = MovieService();
  final _seriesApiClient = SeriesApiClient();

  String _locale = '';
  late DateFormat _dateFormat;
  PopularMovieResponse? _popularMovieResponse;
  PopularSeriesResponse? _popularSeriesResponse;

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  PopularSeriesResponse? get popularSeriesResponse => _popularSeriesResponse;
  PopularMovieResponse? get popularMovieResponse => _popularMovieResponse;
  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMEd(locale);
    await _loadMovies(_locale);
    await _loadSeries(_locale);
    notifyListeners();
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _popularMovieResponse?.movies[index].id;
    Navigator.of(context)
        .pushNamed(MainNavigationRouteName.movieDetails, arguments: id);
  }

  void onSeriesTap(BuildContext context, int index) {
    final id = _popularSeriesResponse?.series[index].id;
    Navigator.of(context)
        .pushNamed(MainNavigationRouteName.seriesDetails, arguments: id);
  }

  Future _loadMovies(String locale) async {
    _popularMovieResponse = await _movieApiClient.popularMovie(1, _locale);
  }

  Future _loadSeries(String locale) async {
    _popularSeriesResponse = await _seriesApiClient.popularSeries(1, _locale);
  }
}

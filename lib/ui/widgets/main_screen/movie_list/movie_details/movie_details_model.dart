import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';

import '../../../../../domain/entity/movie_details.dart';
import '../../../../../domain/entity/movie_details_rec.dart';
import '../../../../routes/routes.dart';

class MovieDetailsModel extends ChangeNotifier {
  final _apiClient = ApiClient();

  final int movieId;
  MovieDetails? _movieDetails;
  MovieDetailsRec? _movieDetailsRec;
  String _locale = '';
  late DateFormat _dateFormat;

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  MovieDetails? get movieDetails => _movieDetails;
  MovieDetailsRec? get movieDetailRec => _movieDetailsRec;

  MovieDetailsModel(
    this.movieId,
  );

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMEd(locale);
    await _loadDetails();
    await _loadRec();
  }

  Future<void> _loadRec() async {
    _movieDetailsRec = await _apiClient.movieDetailsRec(movieId, _locale);
    notifyListeners();
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _movieDetailsRec?.movieRec[index].id;
    Navigator.of(context)
        .pushNamed(MainNavigationRouteName.movieDetails, arguments: id);
  }

  Future<void> _loadDetails() async {
    _movieDetails = await _apiClient.movieDetails(movieId, _locale);

    notifyListeners();
  }
}

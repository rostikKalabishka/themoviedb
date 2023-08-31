import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';

import '../../../../../domain/entity/movie_details.dart';

class MovieDetailsModel extends ChangeNotifier {
  final _apiCLient = ApiClient();

  final int movieId;
  MovieDetails? _movieDetails;
  String _locale = '';
  late DateFormat _dateFormat;

  MovieDetails? get movieDetails => _movieDetails;

  MovieDetailsModel(
    this.movieId,
  );

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMEd(locale);
    await _loadDetails();
  }

  Future<void> _loadDetails() async {
    _movieDetails = await _apiCLient.movieDetails(movieId, _locale);
    notifyListeners();
  }
}

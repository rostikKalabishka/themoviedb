// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:themoviedb/domain/api_client/account_api_client/account_api_client.dart';
import 'package:themoviedb/domain/api_client/movie_api_client/movie_api_client.dart';
import 'package:themoviedb/domain/services/auth_service/auth_service.dart';

import '../../../../../domain/api_client/api_client_exaption.dart';
import '../../../../../domain/api_client/data_providers/session_data_provider.dart';
import '../../../../../domain/entity/movie/movie_details/movie_details.dart';
import '../../../../../domain/entity/movie/movie_details_rec/movie_details_rec.dart';
import '../../../../routes/routes.dart';

class MovieDetailsPosterData {
  final String? backdropPath;
  final String? posterPath;
  final bool isFavorite;
  IconData get favoriteIcon =>
      isFavorite ? Icons.favorite : Icons.favorite_outline;

  MovieDetailsPosterData(
      {this.backdropPath, this.posterPath, bool isFavorite = false})
      : isFavorite = isFavorite;

  MovieDetailsPosterData copyWith({
    String? backdropPath,
    String? posterPath,
    bool? isFavorite,
  }) {
    return MovieDetailsPosterData(
      backdropPath: backdropPath ?? this.backdropPath,
      posterPath: posterPath ?? this.posterPath,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class MovieDetailsNameData {
  final String movieName;
  final String? movieYear;

  MovieDetailsNameData({this.movieName = '', this.movieYear = ''});
}

class MovieDetailsScoreData {
  final String? trailerKey;
  final double voteAverage;

  MovieDetailsScoreData({this.trailerKey, required this.voteAverage});
}

class MovieDetailsPeopleData {
  final String name;
  final String job;
  MovieDetailsPeopleData({
    required this.name,
    required this.job,
  });
}

class MovieDetailsActorData {
  final String? name;
  final String? profilePath;
  final String? character;

  MovieDetailsActorData({this.name, this.profilePath, this.character});
}

class MovieDetailsData {
  String title = '';
  bool isLoading = true;
  String overview = '';
  MovieDetailsPosterData posterData = MovieDetailsPosterData();
  MovieDetailsNameData nameData = MovieDetailsNameData();
  MovieDetailsScoreData scoreData = MovieDetailsScoreData(voteAverage: 0);
  String summary = '';
  List<List<MovieDetailsPeopleData>> peopleData = const [];
  List<MovieDetailsActorData> actorData = const [];
}

class MovieDetailsModel extends ChangeNotifier {
  final _authService = AuthService();
  final _movieApiClient = MovieApiClient();
  final _accountApiClient = AccountApiClient();

  final data = MovieDetailsData();
  final int movieId;

  MovieDetailsRec? _movieDetailsRec;
  String _locale = '';
  bool _isFavorite = false;
  final _sessionDataProvide = SessionDataProvider();
  late DateFormat _dateFormat;
  late String _errorMessage;

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  MovieDetailsRec? get movieDetailRec => _movieDetailsRec;
  String? get errorMessage => _errorMessage;

  MovieDetailsModel(
    this.movieId,
  );

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMEd(locale);
    updateData(null, false);
    await _loadDetails(context);
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _movieDetailsRec?.movieRec[index].id;
    Navigator.of(context)
        .pushNamed(MainNavigationRouteName.movieDetails, arguments: id);
  }

  Future<void> _loadDetails(BuildContext context) async {
    try {
      final sessionId = await _sessionDataProvide.getSessionId();
      final movieDetails = await _movieApiClient.movieDetails(movieId, _locale);
      var isFavorite;
      _movieDetailsRec =
          await _movieApiClient.movieDetailsRec(movieId, _locale);
      if (sessionId != null) {
        isFavorite = await _movieApiClient.isFavorite(movieId, sessionId);
      }

      updateData(movieDetails, isFavorite);
    } on ApiClientException catch (e) {
      _handleApiClientException(e, context);
    }
  }

  String makeSummary(MovieDetails details) {
    var texts = <String>[];
    final releaseDate = (details.releaseDate);

    if (releaseDate != null) {
      texts.add(stringFromDate(releaseDate));
    }
    final productionCountries = details.productionCountries;
    if (productionCountries.isNotEmpty) {
      final name = '(${productionCountries.first.iso})';
      texts.add(name);
    }

    final runtime = details.runtime;

    final durationRuntime = Duration(minutes: runtime);
    final hours = durationRuntime.inHours;
    final minutes = durationRuntime.inMinutes.remainder(60);
    texts.add('${hours}h ${minutes}m');

    final genres = details.genres;
    if (genres.isNotEmpty) {
      var genresNames = <String>[];
      for (var genr in genres) {
        genresNames.add(genr.name);
      }
      texts.add(genresNames.join(', '));
    }
    return texts.join(' ');
  }

  List<List<MovieDetailsPeopleData>> makeListPeopleData(MovieDetails details) {
    var crew = details.credits.crew
        .map((e) => MovieDetailsPeopleData(name: e.name, job: e.job))
        .toList();

    crew = crew.length > 4 ? crew.sublist(0, 4) : crew;

    var crewChanks = <List<MovieDetailsPeopleData>>[];
    for (var i = 0; i < crew.length; i += 2) {
      crewChanks
          .add(crew.sublist(i, i + 2 > crew.length ? crew.length : i + 2));
    }
    return crewChanks;
  }

  void updateData(MovieDetails? details, bool isFavorite) {
    data.title = details?.title ?? 'Download...';
    data.isLoading = details == null;
    if (details == null) {
      notifyListeners();
      return;
    }
    data.overview = details.overview ?? '';
    final iconData = data.posterData = MovieDetailsPosterData(
      backdropPath: details.backdropPath,
      posterPath: details.posterPath,
      isFavorite: isFavorite,
    );
    data.nameData = MovieDetailsNameData(
        movieName: details.title, movieYear: ' (${details.releaseDate?.year})');

    final videos = details.videos.results
        .where((video) => video.type == 'Trailer' && video.site == 'YouTube');
    final trailerKey = videos.isNotEmpty == true ? videos.first.key : null;
    data.scoreData = MovieDetailsScoreData(
        voteAverage: details.voteAverage * 10, trailerKey: trailerKey);
    data.summary = makeSummary(details);

    data.peopleData = makeListPeopleData(details);
    data.actorData = details.credits.cast
        .map(
          (e) => MovieDetailsActorData(
              name: e.name, profilePath: e.profilePath, character: e.character),
        )
        .toList();
    // makeListActorData(details);

    notifyListeners();
  }

  void navigateYoutubeVideos(BuildContext context, String trailerKey) {
    Navigator.of(context)
        .pushNamed(MainNavigationRouteName.movieTrailer, arguments: trailerKey);
  }

  Future<void> toggleFavorite(BuildContext context) async {
    final accountId = await _sessionDataProvide.getAccountId();
    final sessionId = await _sessionDataProvide.getSessionId();

    if (accountId == null || sessionId == null) return;

    data.posterData =
        data.posterData.copyWith(isFavorite: !data.posterData.isFavorite);

    notifyListeners();

    try {
      await _accountApiClient.addFavorite(
          accountId: accountId,
          sessionId: sessionId,
          mediaType: ApiClientMediaType.movie,
          mediaId: movieId,
          isFavorite: data.posterData.isFavorite);
    } on ApiClientException catch (e) {
      _handleApiClientException(e, context);
    }
  }

  void _handleApiClientException(
      ApiClientException exeption, BuildContext context) {
    switch (exeption.type) {
      case ApiClientExceptionType.sessionExpired:
        _authService.logout();
        MainNavigation.resetNavigator(context);

        break;
      default:
        print(exeption);
    }
  }
}

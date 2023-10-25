import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../domain/api_client/api_client_exaption.dart';
import '../../../../../domain/entity/series/series_details/series_details.dart';
import '../../../../../domain/entity/series/series_details_rec/series_details_rec.dart';
import '../../../../../domain/services/auth_service/auth_service.dart';
import '../../../../../domain/services/series_service/series_service.dart';
import '../../../../../library/widgets/locale/locale_strorage_model.dart';
import '../../../../routes/routes.dart';

class SeriesDetailsPosterData {
  final String? backdropPath;
  final String? posterPath;
  final bool isFavorite;
  IconData get favoriteIcon =>
      isFavorite ? Icons.favorite : Icons.favorite_outline;

  SeriesDetailsPosterData(
      {this.backdropPath, this.posterPath, bool isFavorite = false})
      : isFavorite = isFavorite;

  SeriesDetailsPosterData copyWith({
    String? backdropPath,
    String? posterPath,
    bool? isFavorite,
  }) {
    return SeriesDetailsPosterData(
      backdropPath: backdropPath ?? this.backdropPath,
      posterPath: posterPath ?? this.posterPath,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class SeriesDetailsNameData {
  final String seriesName;
  final String? seriesYear;

  SeriesDetailsNameData({this.seriesName = '', this.seriesYear = ''});
}

class SeriesDetailsScoreData {
  final String? trailerKey;
  final double voteAverage;

  SeriesDetailsScoreData({this.trailerKey, required this.voteAverage});
}

class SeriesDetailsPeopleData {
  final String name;
  final String job;
  SeriesDetailsPeopleData({
    required this.name,
    required this.job,
  });
}

class SeriesDetailsActorData {
  final String? name;
  final String? profilePath;
  final String? character;

  SeriesDetailsActorData({this.name, this.profilePath, this.character});
}

class SeriesDetailsRecData {
  final String? name;
  final String? posterPath;
  final double voteAverage;

  SeriesDetailsRecData({this.name = '', this.posterPath, this.voteAverage = 0});
}

class SeriesDetailsData {
  String name = '';
  bool isLoading = true;
  String overview = '';
  SeriesDetailsPosterData posterData = SeriesDetailsPosterData();
  SeriesDetailsNameData nameData = SeriesDetailsNameData();
  SeriesDetailsScoreData scoreData = SeriesDetailsScoreData(voteAverage: 0);
  String summary = '';
  List<List<SeriesDetailsPeopleData>> peopleData = const [];
  List<SeriesDetailsActorData> actorData = const [];

  List<SeriesDetailsRecData> recData = const [];
}

class SeriesDetailsModel extends ChangeNotifier {
  final _seriesService = SeriesService();
  final _authService = AuthService();

  final LocaleStorageModel _localeStorage = LocaleStorageModel();
  final data = SeriesDetailsData();
  final int seriesId;

  SeriesDetailsRec? _seriesDetailsRec;
  bool isFavorite = false;
  late DateFormat _dateFormat;
  late String _errorMessage;

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  SeriesDetailsRec? get seriesDetailRec => _seriesDetailsRec;
  String? get errorMessage => _errorMessage;

  SeriesDetailsModel(
    this.seriesId,
  );

  Future<void> setupLocale(BuildContext context, Locale locale) async {
    if (!_localeStorage.updateLocale(locale)) return;

    _dateFormat = DateFormat.yMMMEd(_localeStorage.localeTag);
    updateData(null, false);
    await _loadDetails(context);
  }

  void onSeriesTap(BuildContext context, int index) {
    final id = _seriesDetailsRec?.seriesRec[index].id;
    Navigator.of(context)
        .pushNamed(MainNavigationRouteName.seriesDetails, arguments: id);
  }

  Future<void> _loadDetails(BuildContext context) async {
    try {
      final details = await _seriesService.loadDetails(
          seriesId: seriesId, locale: _localeStorage.localeTag);

      _seriesDetailsRec = await _seriesService.seriesRec(
          seriesId: seriesId, locale: _localeStorage.localeTag);

      updateData(details.details, details.isFavorite);
    } on ApiClientException catch (e) {
      _handleApiClientException(e, context);
    }
  }

  String makeSummary(SeriesDetails details) {
    var texts = <String>[];
    final releaseDate = (details.firstAirDate);

    if (releaseDate != null) {
      texts.add(stringFromDate(releaseDate));
    }
    final productionCountries = details.productionCountries;
    if (productionCountries.isNotEmpty) {
      final name = '(${productionCountries.first.iso})';
      texts.add(name);
    }

    final genres = details.genres;
    if (genres != null && genres.isNotEmpty) {
      var genresNames = <String>[];
      for (var genr in genres) {
        genresNames.add(genr.name);
      }
      texts.add(genresNames.join(', '));
    }
    return texts.join(' ');
  }

  List<List<SeriesDetailsPeopleData>> makeListPeopleData(
      SeriesDetails details) {
    var crew = details.credits.crew
        .map((e) => SeriesDetailsPeopleData(name: e.name, job: e.job))
        .toList();

    crew = crew.length > 4 ? crew.sublist(0, 4) : crew;

    var crewChanks = <List<SeriesDetailsPeopleData>>[];
    for (var i = 0; i < crew.length; i += 2) {
      crewChanks
          .add(crew.sublist(i, i + 2 > crew.length ? crew.length : i + 2));
    }
    return crewChanks;
  }

  void updateData(SeriesDetails? details, bool isFavorite) {
    data.name = details?.name ?? 'Download...';
    data.isLoading = details == null;
    if (details == null) {
      notifyListeners();
      return;
    }
    data.overview = details.overview;
    data.posterData = SeriesDetailsPosterData(
      backdropPath: details.backdropPath,
      posterPath: details.posterPath,
      isFavorite: isFavorite,
    );
    data.nameData = SeriesDetailsNameData(
        seriesName: details.name,
        seriesYear: ' (${details.firstAirDate?.year})');

    final videos = details.videos.results
        .where((video) => video.type == 'Trailer' && video.site == 'YouTube');
    final trailerKey = videos.isNotEmpty == true ? videos.first.key : null;
    data.scoreData = SeriesDetailsScoreData(
        voteAverage: details.voteAverage * 10, trailerKey: trailerKey);
    data.summary = makeSummary(details);

    data.peopleData = makeListPeopleData(details);
    data.actorData = details.credits.cast
        .map(
          (e) => SeriesDetailsActorData(
              name: e.name, profilePath: e.profilePath, character: e.character),
        )
        .toList();

    notifyListeners();
  }

  void navigateYoutubeVideos(BuildContext context, String trailerKey) {
    Navigator.of(context).pushNamed(MainNavigationRouteName.seriesTrailer,
        arguments: trailerKey);
  }

  Future<void> toggleFavorite(BuildContext context) async {
    data.posterData =
        data.posterData.copyWith(isFavorite: !data.posterData.isFavorite);

    notifyListeners();

    try {
      _seriesService.updateFavorite(
          isFavorite: data.posterData.isFavorite, seriesId: seriesId);
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

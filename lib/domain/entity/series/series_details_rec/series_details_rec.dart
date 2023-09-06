import 'package:json_annotation/json_annotation.dart';
part 'series_details_rec.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SeriesDetailsRec {
  final int page;
  @JsonKey(name: 'results')
  final List<SeriesDetailsRecResult> seriesRec;
  final int totalPages;
  final int totalResults;
  SeriesDetailsRec({
    required this.page,
    required this.seriesRec,
    required this.totalPages,
    required this.totalResults,
  });
  factory SeriesDetailsRec.fromJson(Map<String, dynamic> json) =>
      _$SeriesDetailsRecFromJson(json);
  Map<String, dynamic> toJson() => _$SeriesDetailsRecToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SeriesDetailsRecResult {
  final bool adult;
  final String backdropPath;
  final int id;
  final String name;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final String posterPath;
  final String mediaType;
  final List<int> genreIds;
  final double popularity;
  final String firstAirDate;
  final double voteAverage;
  final int voteCount;
  final List<String> originCountry;
  SeriesDetailsRecResult({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.name,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.genreIds,
    required this.popularity,
    required this.firstAirDate,
    required this.voteAverage,
    required this.voteCount,
    required this.originCountry,
  });
  factory SeriesDetailsRecResult.fromJson(Map<String, dynamic> json) =>
      _$SeriesDetailsRecResultFromJson(json);
  Map<String, dynamic> toJson() => _$SeriesDetailsRecResultToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

import '../date_parser.dart';
part 'series.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Series {
  final String? backdropPath;
  @JsonKey(fromJson: parseMovieDateFromString)
  final DateTime? firstAirDate;
  final List<int> genreIds;
  final int id;
  final String name;
  final List<String>? originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;

  Series(
      {required this.backdropPath,
      required this.firstAirDate,
      required this.genreIds,
      required this.id,
      required this.name,
      required this.originCountry,
      required this.originalLanguage,
      required this.originalName,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.voteAverage,
      required this.voteCount});

  factory Series.fromJson(Map<String, dynamic> json) => _$SeriesFromJson(json);
  Map<String, dynamic> toJson() => _$SeriesToJson(this);
}

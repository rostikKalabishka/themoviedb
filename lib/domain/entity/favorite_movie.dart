import 'package:json_annotation/json_annotation.dart';

part 'favorite_movie.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieFavorite {
  final int page;
  final List<MovieFavoriteResult> results;
  final int totalPages;
  final int totalResults;
  MovieFavorite({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });
  factory MovieFavorite.fromJson(Map<String, dynamic> json) =>
      _$MovieFavoriteFromJson(json);
  Map<String, dynamic> toJson() => _$MovieFavoriteToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieFavoriteResult {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime? releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  MovieFavoriteResult({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });
  factory MovieFavoriteResult.fromJson(Map<String, dynamic> json) =>
      _$MovieFavoriteResultFromJson(json);
  Map<String, dynamic> toJson() => _$MovieFavoriteResultToJson(this);
}

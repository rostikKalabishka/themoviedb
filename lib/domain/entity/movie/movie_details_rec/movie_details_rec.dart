import 'package:json_annotation/json_annotation.dart';

part 'movie_details_rec.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieDetailsRec {
  final int page;
  @JsonKey(name: 'results')
  final List<MovieRec> movieRec;
  final int totalPages;
  final int totalResults;
  MovieDetailsRec({
    required this.page,
    required this.movieRec,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieDetailsRec.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsRecFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDetailsRecToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieRec {
  final String? backdropPath;
  final int id;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  MovieRec({
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieRec.fromJson(Map<String, dynamic> json) =>
      _$MovieRecFromJson(json);
  Map<String, dynamic> toJson() => _$MovieRecToJson(this);
}

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'favorite_series.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class FavoriteSeries {
  final int page;
  final List<FavoriteSeriesResult> results;
  final int totalPages;
  final int totalResults;
  FavoriteSeries({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });
  factory FavoriteSeries.fromJson(Map<String, dynamic> json) =>
      _$FavoriteSeriesFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteSeriesToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class FavoriteSeriesResult {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final DateTime? firstAirDate;
  final String name;
  final double voteAverage;
  final int voteCount;
  FavoriteSeriesResult({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  factory FavoriteSeriesResult.fromJson(Map<String, dynamic> json) =>
      _$FavoriteSeriesResultFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteSeriesResultToJson(this);
}

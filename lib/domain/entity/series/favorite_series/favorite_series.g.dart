// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_series.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteSeries _$FavoriteSeriesFromJson(Map<String, dynamic> json) =>
    FavoriteSeries(
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => FavoriteSeriesResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );

Map<String, dynamic> _$FavoriteSeriesToJson(FavoriteSeries instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results.map((e) => e.toJson()).toList(),
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };

FavoriteSeriesResult _$FavoriteSeriesResultFromJson(
        Map<String, dynamic> json) =>
    FavoriteSeriesResult(
      adult: json['adult'] as bool,
      backdropPath: json['backdrop_path'] as String?,
      genreIds:
          (json['genre_ids'] as List<dynamic>).map((e) => e as int).toList(),
      id: json['id'] as int,
      originCountry: (json['origin_country'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      originalLanguage: json['original_language'] as String,
      originalName: json['original_name'] as String,
      overview: json['overview'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      posterPath: json['poster_path'] as String?,
      firstAirDate: json['first_air_date'] == null
          ? null
          : DateTime.parse(json['first_air_date'] as String),
      name: json['name'] as String,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
    );

Map<String, dynamic> _$FavoriteSeriesResultToJson(
        FavoriteSeriesResult instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'genre_ids': instance.genreIds,
      'id': instance.id,
      'origin_country': instance.originCountry,
      'original_language': instance.originalLanguage,
      'original_name': instance.originalName,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'first_air_date': instance.firstAirDate?.toIso8601String(),
      'name': instance.name,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
    };

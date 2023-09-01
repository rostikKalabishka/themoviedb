// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Series _$SeriesFromJson(Map<String, dynamic> json) => Series(
      backdropPath: json['backdrop_path'] as String?,
      firstAirDate: parseMovieDateFromString(json['first_air_date'] as String?),
      genreIds:
          (json['genre_ids'] as List<dynamic>).map((e) => e as int).toList(),
      id: json['id'] as int,
      name: json['name'] as String,
      originCountry: (json['origin_country'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      originalLanguage: json['original_language'] as String,
      originalName: json['original_name'] as String,
      overview: json['overview'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      posterPath: json['poster_path'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
    );

Map<String, dynamic> _$SeriesToJson(Series instance) => <String, dynamic>{
      'backdrop_path': instance.backdropPath,
      'first_air_date': instance.firstAirDate?.toIso8601String(),
      'genre_ids': instance.genreIds,
      'id': instance.id,
      'name': instance.name,
      'origin_country': instance.originCountry,
      'original_language': instance.originalLanguage,
      'original_name': instance.originalName,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
    };

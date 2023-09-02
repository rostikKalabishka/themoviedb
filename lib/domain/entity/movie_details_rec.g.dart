// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_rec.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailsRec _$MovieDetailsRecFromJson(Map<String, dynamic> json) =>
    MovieDetailsRec(
      page: json['page'] as int,
      movieRec: (json['results'] as List<dynamic>)
          .map((e) => MovieRec.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );

Map<String, dynamic> _$MovieDetailsRecToJson(MovieDetailsRec instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.movieRec.map((e) => e.toJson()).toList(),
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };

MovieRec _$MovieRecFromJson(Map<String, dynamic> json) => MovieRec(
      backdropPath: json['backdrop_path'] as String?,
      id: json['id'] as int,
      title: json['title'] as String,
      video: json['video'] as bool,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
    );

Map<String, dynamic> _$MovieRecToJson(MovieRec instance) => <String, dynamic>{
      'backdrop_path': instance.backdropPath,
      'id': instance.id,
      'title': instance.title,
      'video': instance.video,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
    };

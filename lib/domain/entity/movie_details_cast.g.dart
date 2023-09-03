// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_cast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailsCasts _$MovieDetailsCastsFromJson(Map<String, dynamic> json) =>
    MovieDetailsCasts(
      cast: (json['cast'] as List<dynamic>)
          .map((e) => Actors.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieDetailsCastsToJson(MovieDetailsCasts instance) =>
    <String, dynamic>{
      'cast': instance.cast.map((e) => e.toJson()).toList(),
    };

Actors _$ActorsFromJson(Map<String, dynamic> json) => Actors(
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      profilePath: json['profile_path'] as String?,
    );

Map<String, dynamic> _$ActorsToJson(Actors instance) => <String, dynamic>{
      'name': instance.name,
      'original_name': instance.originalName,
      'profile_path': instance.profilePath,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeriesDetails _$SeriesDetailsFromJson(Map<String, dynamic> json) =>
    SeriesDetails(
      backdropPath: json['backdrop_path'] as String?,
      firstAirDate: json['first_air_date'] == null
          ? null
          : DateTime.parse(json['first_air_date'] as String),
      id: json['id'] as int,
      name: json['name'] as String,
      posterPath: json['poster_path'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
    );

Map<String, dynamic> _$SeriesDetailsToJson(SeriesDetails instance) =>
    <String, dynamic>{
      'backdrop_path': instance.backdropPath,
      'first_air_date': instance.firstAirDate?.toIso8601String(),
      'id': instance.id,
      'name': instance.name,
      'poster_path': instance.posterPath,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
    };

CreatedBy _$CreatedByFromJson(Map<String, dynamic> json) => CreatedBy(
      id: json['id'] as int,
      creditId: json['credit_id'] as String,
      name: json['name'] as String,
      gender: json['gender'] as int,
      profilePath: json['profile_path'] as String,
    );

Map<String, dynamic> _$CreatedByToJson(CreatedBy instance) => <String, dynamic>{
      'id': instance.id,
      'credit_id': instance.creditId,
      'name': instance.name,
      'gender': instance.gender,
      'profile_path': instance.profilePath,
    };

Genre _$GenreFromJson(Map<String, dynamic> json) => Genre(
      id: json['id'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$GenreToJson(Genre instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

LastEpisodeToAir _$LastEpisodeToAirFromJson(Map<String, dynamic> json) =>
    LastEpisodeToAir(
      id: json['id'] as int,
      name: json['name'] as String,
      overview: json['overview'] as String,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
      airDate: json['air_date'] as String,
      episodeNumber: json['episode_number'] as int,
      productionCode: json['production_code'] as String,
      runtime: json['runtime'] as int,
      seasonNumber: json['season_number'] as int,
      showId: json['show_id'] as int,
      stillPath: json['still_path'] as String,
    );

Map<String, dynamic> _$LastEpisodeToAirToJson(LastEpisodeToAir instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'overview': instance.overview,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'air_date': instance.airDate,
      'episode_number': instance.episodeNumber,
      'production_code': instance.productionCode,
      'runtime': instance.runtime,
      'season_number': instance.seasonNumber,
      'show_id': instance.showId,
      'still_path': instance.stillPath,
    };

NextEpisodeToAir _$NextEpisodeToAirFromJson(Map<String, dynamic> json) =>
    NextEpisodeToAir();

Map<String, dynamic> _$NextEpisodeToAirToJson(NextEpisodeToAir instance) =>
    <String, dynamic>{};

Network _$NetworkFromJson(Map<String, dynamic> json) => Network(
      id: json['id'] as int,
      logoPath: json['logo_path'] as String,
      name: json['name'] as String,
      originCountry: json['origin_country'] as String,
    );

Map<String, dynamic> _$NetworkToJson(Network instance) => <String, dynamic>{
      'id': instance.id,
      'logo_path': instance.logoPath,
      'name': instance.name,
      'origin_country': instance.originCountry,
    };

ProductionCompanie _$ProductionCompanieFromJson(Map<String, dynamic> json) =>
    ProductionCompanie(
      id: json['id'] as int,
      logoPath: json['logo_path'] as String,
      name: json['name'] as String,
      originCountry: json['origin_country'] as String,
    );

Map<String, dynamic> _$ProductionCompanieToJson(ProductionCompanie instance) =>
    <String, dynamic>{
      'id': instance.id,
      'logo_path': instance.logoPath,
      'name': instance.name,
      'origin_country': instance.originCountry,
    };

ProductionCountrie _$ProductionCountrieFromJson(Map<String, dynamic> json) =>
    ProductionCountrie(
      iso: json['iso_3166_1'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$ProductionCountrieToJson(ProductionCountrie instance) =>
    <String, dynamic>{
      'iso_3166_1': instance.iso,
      'name': instance.name,
    };

Season _$SeasonFromJson(Map<String, dynamic> json) => Season(
      airDate: json['air_date'] as String,
      episodeCount: json['episode_count'] as int,
      id: json['id'] as int,
      name: json['name'] as String,
      overview: json['overview'] as String,
      posterPath: json['poster_path'] as String,
      seasonNumber: json['season_number'] as int,
      voteAverage: json['vote_average'] as int,
    );

Map<String, dynamic> _$SeasonToJson(Season instance) => <String, dynamic>{
      'air_date': instance.airDate,
      'episode_count': instance.episodeCount,
      'id': instance.id,
      'name': instance.name,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'season_number': instance.seasonNumber,
      'vote_average': instance.voteAverage,
    };

SpokenLanguage _$SpokenLanguageFromJson(Map<String, dynamic> json) =>
    SpokenLanguage(
      englishName: json['english_name'] as String,
      iso: json['iso_639_1'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$SpokenLanguageToJson(SpokenLanguage instance) =>
    <String, dynamic>{
      'english_name': instance.englishName,
      'iso_639_1': instance.iso,
      'name': instance.name,
    };

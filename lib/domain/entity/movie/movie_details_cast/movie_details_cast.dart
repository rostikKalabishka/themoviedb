import 'package:json_annotation/json_annotation.dart';

part 'movie_details_cast.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieDetailsCasts {
  final List<Actors> cast;
  final List<Crew> crew;

  MovieDetailsCasts({required this.cast, required this.crew});

  factory MovieDetailsCasts.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsCastsFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDetailsCastsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Actors {
  final bool adult;
  final int? gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final int castId;
  final String character;
  final String creditId;
  final int order;
  Actors({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });
  factory Actors.fromJson(Map<String, dynamic> json) => _$ActorsFromJson(json);
  Map<String, dynamic> toJson() => _$ActorsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Crew {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final String creditId;
  final String department;
  final String job;
  Crew({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.creditId,
    required this.department,
    required this.job,
  });
  factory Crew.fromJson(Map<String, dynamic> json) => _$CrewFromJson(json);
  Map<String, dynamic> toJson() => _$CrewToJson(this);
}

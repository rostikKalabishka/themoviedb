import 'package:json_annotation/json_annotation.dart';
part 'series_details_cast.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SeriesDetailsCast {
  final List<Cast> cast;
  final List<Crew> crew;

  SeriesDetailsCast({
    required this.cast,
    required this.crew,
  });
  factory SeriesDetailsCast.fromJson(Map<String, dynamic> json) =>
      _$SeriesDetailsCastFromJson(json);
  Map<String, dynamic> toJson() => _$SeriesDetailsCastToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Cast {
  final bool adult;
  final int gender;
  final int id;
  final String? knownForDepartment;
  final String name;
  final String? originalName;
  final double popularity;
  final String? profilePath;
  final String? character;
  final String? creditId;
  final int order;
  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.character,
    required this.creditId,
    required this.order,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);
  Map<String, dynamic> toJson() => _$CastToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Crew {
  final bool adult;
  final int gender;
  final int id;
  final String? knownForDepartment;
  final String name;
  final String? originalName;
  final double popularity;
  final String? profilePath;
  final String? creditId;
  final String? department;
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

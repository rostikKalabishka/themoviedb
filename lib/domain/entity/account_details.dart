import 'package:json_annotation/json_annotation.dart';
part 'account_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class AccountDetails {
  final Avatar avatar;
  final int id;
  @JsonKey(name: 'iso_639_1')
  final String iso6391;
  @JsonKey(name: 'iso_3166_1')
  final String iso31661;
  final String name;
  final bool includeAdult;
  final String username;
  AccountDetails({
    required this.avatar,
    required this.id,
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.includeAdult,
    required this.username,
  });
  factory AccountDetails.fromJson(Map<String, dynamic> json) =>
      _$AccountDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$AccountDetailsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Avatar {
  final Gravatar gravatar;
  final Tmdb tmdb;
  Avatar({
    required this.gravatar,
    required this.tmdb,
  });
  factory Avatar.fromJson(Map<String, dynamic> json) => _$AvatarFromJson(json);
  Map<String, dynamic> toJson() => _$AvatarToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Gravatar {
  final String hash;
  Gravatar({
    required this.hash,
  });
  factory Gravatar.fromJson(Map<String, dynamic> json) =>
      _$GravatarFromJson(json);
  Map<String, dynamic> toJson() => _$GravatarToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Tmdb {
  final String avatarPath;
  Tmdb({
    required this.avatarPath,
  });
  factory Tmdb.fromJson(Map<String, dynamic> json) => _$TmdbFromJson(json);
  Map<String, dynamic> toJson() => _$TmdbToJson(this);
}

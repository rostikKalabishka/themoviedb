import 'package:json_annotation/json_annotation.dart';

part 'series_details_video.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SeriesDetailsVideo {
  final int id;
  final List<SeriesDetailsVideoResult> results;
  SeriesDetailsVideo({
    required this.id,
    required this.results,
  });
  factory SeriesDetailsVideo.fromJson(Map<String, dynamic> json) =>
      _$SeriesDetailsVideoFromJson(json);
  Map<String, dynamic> toJson() => _$SeriesDetailsVideoToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SeriesDetailsVideoResult {
  @JsonKey(name: 'iso_639_1')
  final String iso6391;
  @JsonKey(name: 'iso_3166_1')
  final String iso31661;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final String publishedAt;
  final String id;
  SeriesDetailsVideoResult({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });
  factory SeriesDetailsVideoResult.fromJson(Map<String, dynamic> json) =>
      _$SeriesDetailsVideoResultFromJson(json);
  Map<String, dynamic> toJson() => _$SeriesDetailsVideoResultToJson(this);
}

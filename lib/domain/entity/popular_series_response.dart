import 'package:json_annotation/json_annotation.dart';
import 'package:themoviedb/domain/entity/series.dart';
part 'popular_series_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PopularSeriesResponse {
  final int page;
  @JsonKey(name: 'results')
  final List<Series> series;
  final int totalResults;
  final int totalPages;

  PopularSeriesResponse(
      {required this.page,
      required this.series,
      required this.totalResults,
      required this.totalPages});

  factory PopularSeriesResponse.fromJson(Map<String, dynamic> json) =>
      _$PopularSeriesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PopularSeriesResponseToJson(this);
}

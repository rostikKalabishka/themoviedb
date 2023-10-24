import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/entity/series/series.dart';
import 'package:themoviedb/domain/services/series_service/series_service.dart';
import 'package:themoviedb/library/widgets/paginator/paginator.dart';

import '../../../../library/widgets/locale/locale_strorage_model.dart';
import '../../../routes/routes.dart';

class SeriesListRowData {
  final int id;
  final String name;
  final String firstAirDate;
  final String overview;
  final String? posterPath;

  SeriesListRowData({
    required this.id,
    required this.name,
    required this.firstAirDate,
    required this.overview,
    required this.posterPath,
  });
}

class SeriesListModel extends ChangeNotifier {
  final _seriesService = SeriesService();

  late final Paginator<Series> _popularSeriesPaginator;
  late final Paginator<Series> _searchSeriesPaginator;
  var _series = <SeriesListRowData>[];

  String? _searchQuery;

  final LocaleStorageModel _localeStorage = LocaleStorageModel();
  Timer? searchDebounce;
  SeriesListModel() {
    _popularSeriesPaginator = Paginator<Series>(
      (page) async {
        final result =
            await _seriesService.popularSeries(page, _localeStorage.localeTag);
        return PaginatorLoadResult(
            data: result.series,
            currentPage: result.page,
            totalPage: result.totalPages);
      },
    );
    _searchSeriesPaginator = Paginator<Series>(
      (page) async {
        final result = await _seriesService.searchSeries(
            page, _localeStorage.localeTag, _searchQuery ?? '');
        return PaginatorLoadResult(
            data: result.series,
            currentPage: result.page,
            totalPage: result.totalPages);
      },
    );
  }
  List<SeriesListRowData> get series => List.unmodifiable(_series);
  late DateFormat _dateFormat;

  bool get isSearchMode {
    final searchQuery = _searchQuery;
    return searchQuery != null && searchQuery.isNotEmpty;
  }

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  Future<void> setupLocale(Locale locale) async {
    _localeStorage.updateLocale(locale);
    _dateFormat = DateFormat.yMMMEd(_localeStorage.localeTag);
    await _resetList();
  }

  Future<void> _resetList() async {
    await _popularSeriesPaginator.reset();
    await _searchSeriesPaginator.reset();

    _series.clear();
    await _loadNextPage();
  }

  SeriesListRowData _makeRowData(Series series) {
    return SeriesListRowData(
        firstAirDate: stringFromDate(series.firstAirDate),
        id: series.id,
        name: series.name,
        overview: series.overview,
        posterPath: series.posterPath);
  }

  Future<void> _loadNextPage() async {
    if (isSearchMode) {
      await _searchSeriesPaginator.loadNextPage();
      _series = _searchSeriesPaginator.data.map(_makeRowData).toList();
    } else {
      await _popularSeriesPaginator.loadNextPage();
      _series = _popularSeriesPaginator.data.map(_makeRowData).toList();
    }
    notifyListeners();
  }

  Future<void> searchSeries(String text) async {
    searchDebounce?.cancel();
    searchDebounce = Timer(const Duration(milliseconds: 200), () async {
      final searchQuery = text.isNotEmpty ? text : null;
      if (_searchQuery == searchQuery) return;
      _searchQuery = searchQuery;
      _series.clear();
      if (isSearchMode) {
        await _searchSeriesPaginator.reset();
      }
      _loadNextPage();
    });
  }

  void onSeriesTap(BuildContext context, int index) {
    final id = _series[index].id;

    Navigator.of(context)
        .pushNamed(MainNavigationRouteName.seriesDetails, arguments: id);
    // }
  }

  void showedSeriesAtIndex(int index) {
    if (index < series.length - 1) return;
    _loadNextPage();
  }
}

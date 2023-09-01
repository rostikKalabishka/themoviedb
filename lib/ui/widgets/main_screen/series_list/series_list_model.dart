import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/entity/popular_series_response.dart';
import 'package:themoviedb/domain/entity/series.dart';
import '../../../../domain/api_client/api_client.dart';
import '../../../routes/routes.dart';

class SeriesListModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _series = <Series>[];
  late int _currentPage;
  late int _totalPage;
  var _isLoadingInProgress = false;
  String? _searchQuery;
  String _locale = '';
  Timer? searchDebounce;

  List<Series> get series => List.unmodifiable(_series);
  late DateFormat _dateFormat;

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMEd(locale);
    await _resetList();
  }

  Future<void> _resetList() async {
    _currentPage = 0;
    _totalPage = 1;
    _series.clear();
    await _loadNextPage();
  }

  Future<PopularSeriesResponse> _loadSeries(int nextPage, String locale) async {
    final query = _searchQuery;
    if (query == null) {
      await _apiClient.popularSeries(nextPage, _locale);
      return await _apiClient.popularSeries(nextPage, _locale);
      ;
    } else {
      return await _apiClient.searchSeries(nextPage, _locale, query);
    }
  }

  Future<void> _loadNextPage() async {
    if (_isLoadingInProgress || _currentPage >= _totalPage) return;
    _isLoadingInProgress = true;
    final nexPage = _currentPage + 1;

    try {
      final seriesResponse = await _loadSeries(nexPage, _locale);
      _series.addAll(seriesResponse.series);
      _currentPage = seriesResponse.page;
      _totalPage = seriesResponse.totalPages;
      _isLoadingInProgress = false;
      notifyListeners();
    } catch (e) {
      _isLoadingInProgress = false;
    }
  }

  Future<void> searchSeries(String text) async {
    searchDebounce?.cancel();
    searchDebounce = Timer(const Duration(milliseconds: 200), () async {
      final searchQuery = text.isNotEmpty ? text : null;
      if (_searchQuery == searchQuery) return;
      _searchQuery = searchQuery;
      await _resetList();
    });
  }

  void onSeriesTap(BuildContext context, int index) {
    final id = _series[index].id;
    Navigator.of(context)
        .pushNamed(MainNavigationRouteName.seriesDetails, arguments: id);
  }

  void showedSeriesAtIndex(int index) {
    if (index < series.length - 1) return;
    _loadNextPage();
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:themoviedb/library/widgets/paginator/paginator.dart';
import 'package:themoviedb/ui/routes/routes.dart';

import '../../../../domain/entity/movie/movie.dart';
import '../../../../domain/services/movie_service/movie_service.dart';
import '../../../../library/widgets/locale/locale_strorage_model.dart';

class MovieListRowData {
  final int id;
  final String title;
  final String? posterPath;
  final String overview;
  final String releaseDate;
  MovieListRowData({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
  });
}

class MovieListModel extends ChangeNotifier {
  final _movieService = MovieService();

  String? _searchQuery;
  final LocaleStorageModel _localeStorage = LocaleStorageModel();
  Timer? searchDebounce;

  late final Paginator<Movie> _popularMoviePaginator;
  late final Paginator<Movie> _searchMoviePaginator;
  var _movies = <MovieListRowData>[];

  List<MovieListRowData> get movies => List.unmodifiable(_movies);
  late DateFormat _dateFormat;

  bool get isSearchMode {
    final searchQuery = _searchQuery;
    return searchQuery != null && searchQuery.isNotEmpty;
  }

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';
  MovieListModel() {
    _popularMoviePaginator = Paginator<Movie>(
      (page) async {
        final result =
            await _movieService.popularMovie(page, _localeStorage.localeTag);
        return PaginatorLoadResult(
            data: result.movies,
            currentPage: result.page,
            totalPage: result.totalPages);
      },
    );

    _searchMoviePaginator = Paginator<Movie>(
      (page) async {
        final result = await _movieService.searchMovie(
            page, _localeStorage.localeTag, _searchQuery ?? '');
        return PaginatorLoadResult(
            data: result.movies,
            currentPage: result.page,
            totalPage: result.totalPages);
      },
    );
  }

  Future<void> setupLocale(Locale locale) async {
    _localeStorage.updateLocale(locale);
    _dateFormat = DateFormat.yMMMEd(_localeStorage.localeTag);
    await _resetList();
  }

  MovieListRowData _makeRowData(Movie movie) {
    return MovieListRowData(
      id: movie.id,
      overview: movie.overview,
      posterPath: movie.posterPath,
      releaseDate: stringFromDate(movie.releaseDate),
      title: movie.title,
    );
  }

  Future<void> _resetList() async {
    await _popularMoviePaginator.reset();
    await _searchMoviePaginator.reset();
    _movies.clear();
    await _loadNextPage();
  }

  Future<void> _loadNextPage() async {
    if (isSearchMode) {
      await _searchMoviePaginator.loadNextPage();
      _movies = _searchMoviePaginator.data.map(_makeRowData).toList();
    } else {
      await _popularMoviePaginator.loadNextPage();
      _movies = _popularMoviePaginator.data.map(_makeRowData).toList();
    }
    notifyListeners();
  }

  Future<void> searchMovie(String text) async {
    searchDebounce?.cancel();
    searchDebounce = Timer(const Duration(milliseconds: 200), () async {
      final searchQuery = text.isNotEmpty ? text : null;
      if (_searchQuery == searchQuery) return;
      _searchQuery = searchQuery;
      _movies.clear();
      if (isSearchMode) {
        await _searchMoviePaginator.reset();
      }
      _loadNextPage();
    });
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context)
        .pushNamed(MainNavigationRouteName.movieDetails, arguments: id);
  }

  void showedMovieAtIndex(int index) {
    if (index < movies.length - 1) return;
    _loadNextPage();
  }
}

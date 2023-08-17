import 'package:flutter/material.dart';
import 'package:themoviedb/resources/resources.dart';

class Movie {
  const Movie({
    required this.id,
    required this.imageName,
    required this.title,
    required this.time,
    required this.description,
  });
  final int id;
  final String imageName;
  final String title;
  final String time;
  final String description;
}

class MovieListWidget extends StatefulWidget {
  MovieListWidget({super.key});

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final _listMovie = [
    const Movie(
      id: 1,
      imageName: AppImages.spiderMan,
      title: 'Spider-Man',
      description:
          'Цього разу на Майлза Моралеса чекає несподівана подорож крізь всесвіт, у якій він об’єднає зусилля з Ґвен Стейсі та новою командою «павуків», щоби протистояти наймогутнішому лиходію, котрого вони коли-небудь зустрічали.',
      time: 'Aug 16, 2023',
    ),
    const Movie(
      id: 2,
      imageName: AppImages.spiderMan,
      title: 'Gigga-Man',
      description: 'biba boba123',
      time: 'Aug 12, 2023',
    ),
    const Movie(
      id: 3,
      imageName: AppImages.spiderMan,
      title: 'SMan',
      description: 'sadsadasdadadasd',
      time: 'Jun 11, 2023',
    ),
    const Movie(
      id: 4,
      imageName: AppImages.spiderMan,
      title: 'SMan',
      description: 'sadsadasdadadasd',
      time: 'Jun 11, 2023',
    ),
    const Movie(
      id: 5,
      imageName: AppImages.spiderMan,
      title: 'FFFFF',
      description: 'FFFFFFFFFFFFFFFFF',
      time: 'Jun 111, 2023',
    ),
    const Movie(
      id: 6,
      imageName: AppImages.spiderMan,
      title: 'Vafelnoe Morozeno',
      description: '12312312312312313123123213123133123',
      time: 'Jun 11, 2023',
    )
  ];

  var _filtredMovies = <Movie>[];

  final _searchController = TextEditingController();

  void _searchMovies() {
    setState(() {
      final query = _searchController.text;
      if (query.isNotEmpty) {
        _filtredMovies = _listMovie.where((Movie movie) {
          return movie.title.toLowerCase().contains(query.toLowerCase());
        }).toList();
      } else {
        _filtredMovies = _listMovie;
      }
    });
  }

  void _onMovieTab(int index) {
    final id = _listMovie[index].id;

    Navigator.of(context)
        .pushNamed('/main_screen/movie_details', arguments: id);
  }

  @override
  void initState() {
    // _searchController.text;
    super.initState();
    _filtredMovies = _listMovie;
    _searchController.addListener(_searchMovies);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView.builder(
          padding: EdgeInsets.only(top: 80),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: _filtredMovies.length,
          itemExtent: 163,
          itemBuilder: (BuildContext context, int index) {
            final listMovie = _filtredMovies[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black.withOpacity(0.2)),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2)),
                      ]),
                  clipBehavior: Clip.hardEdge,
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage(listMovie.imageName),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              listMovie.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              listMovie.time,
                              style: const TextStyle(color: Colors.grey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              listMovie.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    onTap: () {
                      _onMovieTab(index);
                    },
                  ),
                )
              ]),
            );
          }),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
              labelText: 'Search',
              filled: true,
              fillColor: Colors.white.withAlpha(235),
              border: const OutlineInputBorder()),
        ),
      ),
    ]);
  }
}

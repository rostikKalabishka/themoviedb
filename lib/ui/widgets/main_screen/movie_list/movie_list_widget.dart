import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../domain/api_client/network_client.dart';

import 'movie_list_model.dart';

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({super.key});

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final locale = Localizations.localeOf(context);

    context.read<MovieListModel>().setupLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return const Stack(children: [
      ListViewMovie(),
      _SearchMovie(),
    ]);
  }
}

class ListViewMovie extends StatelessWidget {
  const ListViewMovie({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MovieListModel>();
    return ListView.builder(
        padding: const EdgeInsets.only(top: 80),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemCount: model.movies.length,
        itemExtent: 163,
        itemBuilder: (BuildContext context, int index) {
          model.showedMovieAtIndex(index);
          return MovieListRowWidget(
            index: index,
          );
        });
  }
}

class _SearchMovie extends StatelessWidget {
  const _SearchMovie({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<MovieListModel>();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        onChanged: model.searchMovie,
        decoration: InputDecoration(
            labelText: 'Search',
            filled: true,
            fillColor: Colors.white.withAlpha(235),
            border: const OutlineInputBorder()),
      ),
    );
  }
}

class MovieListRowWidget extends StatelessWidget {
  const MovieListRowWidget({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    final model = context.read<MovieListModel>();
    final listMovie = model.movies[index];
    final posterPath = listMovie.posterPath;
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
              posterPath != null
                  ? Image.network(
                      NetworkClient.imageUrl(posterPath),
                      width: 95,
                    )
                  : const SizedBox.shrink(),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      listMovie.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      listMovie.releaseDate,
                      style: const TextStyle(color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      listMovie.overview,
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
            onTap: () => model.onMovieTap(context, index),
          ),
        )
      ]),
    );
  }
}

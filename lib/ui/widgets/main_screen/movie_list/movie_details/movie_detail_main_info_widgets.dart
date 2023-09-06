import 'package:flutter/material.dart';

import 'package:themoviedb/domain/api_client/api_client.dart';

import '../../../../../domain/entity/movie/movie_details_cast/movie_details_cast.dart';
import '../../../../../library/widgets/inherited/provider.dart';
import '../../../../routes/routes.dart';
import '../../user_score/user_score.dart';
import 'movie_details_model.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _TopPosterWidget(),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: _FilmsInfo(),
        ),
        _ButtonWidget(),
        Divider(
          color: Colors.black26,
        ),
        _FactsMovie(),
        Divider(
          color: Colors.black26,
        ),
        Overview()
      ],
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final backdropPath = model?.movieDetails?.backdropPath;
    final posterPath = model?.movieDetails?.posterPath;

    return AspectRatio(
      aspectRatio: 390 / 219.2,
      child: Stack(
        children: [
          backdropPath != null
              ? Image.network(ApiClient.imageUrl(backdropPath))
              : const SizedBox.shrink(),
          posterPath != null
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Image.network(
                    ApiClient.imageUrl(posterPath),
                    width: 90,
                    height: 150,
                  ),
                )
              : const SizedBox.shrink(),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              icon: Icon(
                Icons.favorite,
                color:
                    model?.isFavorite == true ? Colors.red : Colors.grey[700],
              ),
              onPressed: () => model?.toggleFavorite(),
            ),
          )
        ],
      ),
    );
  }
}

class _FilmsInfo extends StatelessWidget {
  const _FilmsInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final movieName = model?.movieDetails?.title;
    var year = model?.movieDetails?.releaseDate?.year.toString();
    year = year != null ? ' ($year)' : '';
    return RichText(
      maxLines: 3,
      text: TextSpan(children: [
        TextSpan(
            text: movieName ?? '',
            style: const TextStyle(color: Colors.white, fontSize: 20)),
        TextSpan(
            text: year, style: TextStyle(color: Colors.grey[300], fontSize: 18))
      ]),
    );
  }
}

class _ButtonWidget extends StatelessWidget {
  const _ButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);

    var percent = (model?.movieDetails?.voteAverage) ?? 0;
    percent = percent * 10;
    final videos = model?.movieDetails?.videos.results
        .where((video) => video.type == 'Trailer' && video.site == 'YouTube');
    final trailerKey = videos?.isNotEmpty == true ? videos?.first.key : null;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: RadialPercentWidget(
                  fillColors: Colors.black,
                  lineColor: Colors.green,
                  lineWidth: 3,
                  freeColor: Colors.red,
                  percent: percent / 100,
                  child: Text(
                    percent.toStringAsFixed(0),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text('User Score',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        trailerKey != null
            ? Container(
                color: Colors.white,
                height: 20,
                width: 1,
              )
            : const SizedBox.shrink(),
        trailerKey != null
            ? TextButton(
                onPressed: () => Navigator.of(context).pushNamed(
                    MainNavigationRouteName.movieTrailer,
                    arguments: trailerKey),
                child: const Row(
                  children: [
                    Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                    Text('Play Trailer',
                        style: TextStyle(color: Colors.white, fontSize: 16))
                  ],
                ))
            : const SizedBox.shrink()
      ],
    );
  }
}

class _FactsMovie extends StatelessWidget {
  const _FactsMovie({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    if (model == null) return SizedBox.shrink();
    var texts = <String>[];
    final releaseDate = (model.movieDetails?.releaseDate);

    if (releaseDate != null) {
      texts.add(model.stringFromDate(releaseDate));
    }
    final productionCountries = model.movieDetails?.productionCountries;
    if (productionCountries != null && productionCountries.isNotEmpty) {
      final name = '(${productionCountries.first.iso})';
      texts.add(name);
    }

    final runtime = model.movieDetails?.runtime ?? 0;

    final durationRuntime = Duration(minutes: runtime);
    final hours = durationRuntime.inHours;
    final minutes = durationRuntime.inMinutes.remainder(60);
    texts.add('${hours}h ${minutes}m');

    final genres = model.movieDetails?.genres;
    if (genres != null && genres.isNotEmpty) {
      var genresNames = <String>[];
      for (var genr in genres) {
        genresNames.add(genr.name);
      }
      texts.add(genresNames.join(', '));
    }
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Center(
            child: Text(texts.join(' '),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 16))));
  }
}

class Overview extends StatelessWidget {
  const Overview({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    var crew = model?.movieDetails?.credits.crew;
    if (crew == null || crew.isEmpty) return const SizedBox.shrink();
    crew = crew.length > 4 ? crew.sublist(0, 4) : crew;

    final overview = model?.movieDetails?.overview;

    var crewChanks = <List<Crew>>[];
    for (var i = 0; i < crew.length; i += 2) {
      crewChanks
          .add(crew.sublist(i, i + 2 > crew.length ? crew.length : i + 2));
    }
    var peopleWidgetsRow = crewChanks
        .map(
          (chunk) => Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: _PeopleWidgetsRow(crew: chunk),
          ),
        )
        .toList();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overview',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            overview ?? '',
            style: const TextStyle(fontSize: 15, color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          ...peopleWidgetsRow
        ],
      ),
    );
  }
}

class _PeopleWidgetsRow extends StatelessWidget {
  final List<Crew> crew;
  const _PeopleWidgetsRow({super.key, required this.crew});

  @override
  Widget build(BuildContext context) {
    return Row(
        children:
            crew.map((crews) => _PeopleWidgetRowItems(crew: crews)).toList());
  }
}

class _PeopleWidgetRowItems extends StatelessWidget {
  final Crew crew;
  const _PeopleWidgetRowItems({super.key, required this.crew});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            crew.name,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(crew.job, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/api_client/network_client.dart';
import '../../../../../domain/entity/series/series_details_cast/series_details_cast.dart';

import '../../user_score/user_score.dart';
import 'series_details_model.dart';

class SeriesDetailsMainInfoWidget extends StatelessWidget {
  const SeriesDetailsMainInfoWidget({super.key});

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
        _FactsSeries(),
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
    final model = context.watch<SeriesDetailsModel>();
    final backdropPath = model.seriesDetails?.backdropPath;
    final posterPath = model.seriesDetails?.posterPath;

    return AspectRatio(
      aspectRatio: 390 / 219.2,
      child: Stack(
        children: [
          backdropPath != null
              ? Image.network(NetworkClient.imageUrl(backdropPath))
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: posterPath != null
                ? Image.network(
                    NetworkClient.imageUrl(posterPath),
                    width: 90,
                    height: 150,
                  )
                : const SizedBox.shrink(),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              icon: Icon(
                Icons.favorite,
                color: model.isFavorite == true ? Colors.red : Colors.grey[700],
              ),
              onPressed: () => model.toggleFavorite(),
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
    final model = context.watch<SeriesDetailsModel>();
    final name = model.seriesDetails?.name;
    var yaer = model.seriesDetails?.firstAirDate?.year.toString();
    return RichText(
      maxLines: 3,
      text: TextSpan(children: [
        TextSpan(
            text: name ?? '321',
            style: const TextStyle(color: Colors.white, fontSize: 20)),
        TextSpan(
            text: ' ($yaer)',
            style: TextStyle(color: Colors.grey[300], fontSize: 18))
      ]),
    );
  }
}

class _ButtonWidget extends StatelessWidget {
  const _ButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SeriesDetailsModel>();
    var percent = (model.seriesDetails?.voteAverage) ?? 0;
    final videos = model.seriesDetails?.videos.results
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
                  percent: percent / 10,
                  child: Text((percent * 10).toStringAsFixed(0)),
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
                onPressed: () =>
                    model.navigateYoutubeVideos(context, trailerKey),
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

class _FactsSeries extends StatelessWidget {
  const _FactsSeries({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SeriesDetailsModel>();

    var texts = <String>[];
    final firstAirDate = (model.seriesDetails?.firstAirDate);

    if (firstAirDate != null) {
      texts.add(model.stringFromDate(firstAirDate));
    }
    final productionCountries = model.seriesDetails?.productionCountries;
    if (productionCountries != null && productionCountries.isNotEmpty) {
      final name = '(${productionCountries.first.iso})';
      texts.add(name);
    }

    final genres = model.seriesDetails?.genres;
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
    final model = context.watch<SeriesDetailsModel>();

    var crew = model.seriesDetails?.credits.crew;
    if (crew == null || crew.isEmpty) return const SizedBox.shrink();
    crew = crew.length > 4 ? crew.sublist(0, 4) : crew;

    final overview = model.seriesDetails?.overview;

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
          overview != null
              ? Text(
                  overview,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                )
              : const SizedBox.shrink(),
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

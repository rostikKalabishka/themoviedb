import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../domain/api_client/network_client.dart';
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
    final seriesDetails =
        context.select((SeriesDetailsModel model) => model.data.posterData);
    final model = context.read<SeriesDetailsModel>();
    final backdropPath = seriesDetails.backdropPath;
    final posterPath = seriesDetails.posterPath;

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
              onPressed: () => model.toggleFavorite(context),
              icon: Icon(seriesDetails.favoriteIcon, color: Colors.red),
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
    final nameData =
        context.select((SeriesDetailsModel model) => model.data.nameData);

    final name = nameData.seriesName;
    var year = nameData.seriesYear;
    return RichText(
      maxLines: 3,
      text: TextSpan(children: [
        TextSpan(
            text: name,
            style: const TextStyle(color: Colors.white, fontSize: 20)),
        TextSpan(
            text: year ?? '',
            style: TextStyle(color: Colors.grey[300], fontSize: 18))
      ]),
    );
  }
}

class _ButtonWidget extends StatelessWidget {
  const _ButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<SeriesDetailsModel>();
    final scoreData =
        context.select((SeriesDetailsModel model) => model.data.scoreData);

    final trailerKey = scoreData.trailerKey;

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
                  percent: scoreData.voteAverage / 100,
                  child: Text((scoreData.voteAverage).toStringAsFixed(0)),
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
        scoreData.trailerKey != null
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
    final texts =
        context.select((SeriesDetailsModel model) => model.data.summary);

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Center(
            child: Text(texts,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 16))));
  }
}

class Overview extends StatelessWidget {
  const Overview({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SeriesDetailsModel>();

    final overview = model.data.overview;

    final crew = model.data.peopleData;
    if (crew.isEmpty) return const SizedBox.shrink();
    var peopleWidgetsRow = crew
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
            overview,
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
  final List<SeriesDetailsPeopleData> crew;
  const _PeopleWidgetsRow({super.key, required this.crew});

  @override
  Widget build(BuildContext context) {
    return Row(
        children:
            crew.map((crews) => _PeopleWidgetRowItems(crew: crews)).toList());
  }
}

class _PeopleWidgetRowItems extends StatelessWidget {
  final SeriesDetailsPeopleData crew;
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

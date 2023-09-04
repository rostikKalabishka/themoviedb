import 'package:flutter/material.dart';

import '../../../../../domain/api_client/api_client.dart';
import '../../../../../library/widgets/inherited/provider.dart';
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
    final model = NotifierProvider.watch<SeriesDetailsModel>(context);
    final backdropPath = model?.seriesDetails?.backdropPath;
    final posterPath = model?.seriesDetails?.posterPath;

    return AspectRatio(
      aspectRatio: 390 / 219.2,
      child: Stack(
        children: [
          backdropPath != null
              ? Image.network(ApiClient.imageUrl(backdropPath))
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: posterPath != null
                ? Image.network(
                    ApiClient.imageUrl(posterPath),
                    width: 90,
                    height: 150,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _FilmsInfo extends StatelessWidget {
  const _FilmsInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<SeriesDetailsModel>(context);
    final name = model?.seriesDetails?.name;
    var yaer = model?.seriesDetails?.firstAirDate?.year.toString();
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
    final model = NotifierProvider.watch<SeriesDetailsModel>(context);
    var percent = (model?.seriesDetails?.voteAverage) ?? 0;

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
        Container(
          color: Colors.white,
          height: 20,
          width: 1,
        ),
        TextButton(
            onPressed: () {},
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
      ],
    );
  }
}

class _FactsSeries extends StatelessWidget {
  const _FactsSeries({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: const Center(
            child: Text('PG-13 08/18/2023 (US)  2h 7m Action, Science Fiction',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 16))));
  }
}

class Overview extends StatelessWidget {
  const Overview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overview',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            'Recent college grad Jaime Reyes returns home full of aspirations for his future, only to find that home is not quite as he left it. As he searches to find his purpose in the world, fate intervenes when Jaime unexpectedly finds himself in possession of an ancient relic of alien biotechnology: the Scarab.',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Cully Hamner',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    'Characters',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Keith Giffen',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text('Characters', style: TextStyle(color: Colors.white)),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'John Rogers',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text('Characters', style: TextStyle(color: Colors.white)),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Ángel Manuel Soto',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text('Characters', style: TextStyle(color: Colors.white)),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

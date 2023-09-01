import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';

import '../../../../../library/widgets/inherited/provider.dart';
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
      aspectRatio: 390 / 219,
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

class _FactsMovie extends StatelessWidget {
  const _FactsMovie({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final bb = model?.movieDetails?.tagline;
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Center(
            child: Text(bb ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 16))));
  }
}

class Overview extends StatelessWidget {
  const Overview({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final overview = model?.movieDetails?.overview;
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
          const Row(
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
          const SizedBox(
            height: 20,
          ),
          const Row(
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

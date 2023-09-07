import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';

import '../../../../library/widgets/inherited/provider.dart';
import '../user_score/user_score.dart';
import 'home_page_widget_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  @override
  void didChangeDependencies() {
    NotifierProvider.watch<HomePageWidgetModel>(context)?.setupLocale(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: IndexedStack(children: [
        ListView(
          children: const [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text(
                        'Popular Movie',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                PopularMovie(),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text(
                        'Popular TV',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                PopularSeries()
              ],
            ),
          ],
        ),
      ]),
    );
  }
}

class PopularSeries extends StatelessWidget {
  const PopularSeries({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<HomePageWidgetModel>(context);
    if (model == null) return const SizedBox.shrink();
    // final popularMovieResponse = model.popularMovieResponse;

    var series = model.popularSeriesResponse?.series;
    return SizedBox(
      height: 295,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 20,
        itemExtent: 170,
        //  popularMovieResponse?.movies.length,
        itemBuilder: (BuildContext context, int index) {
          if (series == null) return const SizedBox.shrink();
          final posterPath = series[index].posterPath;

          // final percent = series[index].voteAverage;
          var percent = (series[index].voteAverage);
          percent = percent * 10;
          final name = series[index].name;
          final firstAirDate = series[index].firstAirDate;
          final formatFirstAirDate = model.stringFromDate(firstAirDate);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: GestureDetector(
                onTap: () => model.onSeriesTap(context, index),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    children: [
                      Stack(children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black.withOpacity(0.2),
                              width: 1.0,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                          ),
                          child: posterPath != null
                              ? Image.network(
                                  ApiClient.imageUrl(posterPath),
                                  width: 150,
                                  height: 225,
                                )
                              : const SizedBox.shrink(),
                        ),
                        Positioned(
                          right: 5,
                          bottom: 5,
                          child: SizedBox(
                            height: 40,
                            width: 40,
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
                        )
                      ]),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Text(name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 16)),
                            const SizedBox(height: 5),
                            Text(formatFirstAirDate,
                                maxLines: 1,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 77, 73, 73)))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PopularMovie extends StatelessWidget {
  const PopularMovie({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<HomePageWidgetModel>(context);
    if (model == null) return const SizedBox.shrink();

    var movies = model.popularMovieResponse?.movies;
    return SizedBox(
      height: 295,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 20,
        itemExtent: 170,
        //  popularMovieResponse?.movies.length,
        itemBuilder: (BuildContext context, int index) {
          if (movies == null) return const SizedBox.shrink();
          final posterPath = movies[index].posterPath;
          var percent = (movies[index].voteAverage);
          percent = percent * 10;
          final title = movies[index].title;

          final releaseDate = movies[index].releaseDate;
          final formatReleaseDate = model.stringFromDate(releaseDate);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: GestureDetector(
                onTap: () => model.onMovieTap(context, index),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    children: [
                      Stack(children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black.withOpacity(0.2),
                              width: 1.0,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                          ),
                          child: posterPath != null
                              ? Image.network(
                                  ApiClient.imageUrl(posterPath),
                                  width: 150,
                                  height: 225,
                                )
                              : const SizedBox.shrink(),
                        ),
                        Positioned(
                          right: 5,
                          bottom: 5,
                          child: SizedBox(
                            height: 40,
                            width: 40,
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
                        )
                      ]),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Text(title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 16)),
                            const SizedBox(height: 5),
                            Text(formatReleaseDate,
                                maxLines: 1,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 77, 73, 73)))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

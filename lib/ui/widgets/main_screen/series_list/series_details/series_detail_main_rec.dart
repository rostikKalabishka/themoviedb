import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/ui/widgets/main_screen/series_list/series_details/series_details_model.dart';

import '../../../../../library/widgets/inherited/provider.dart';

class SeriesDetailsMainRec extends StatelessWidget {
  const SeriesDetailsMainRec({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<SeriesDetailsModel>(context);
    // if (model == null) return const SizedBox.shrink();
    // final backdropPath = model.seriesDetailsRec?.seriesRec.first.backdropPath;
    // if (backdropPath == null) return const SizedBox.shrink();
    return IndexedStack(
      children: [
        ColoredBox(
          color: Colors.white,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'Recommendations',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  SizedBox(
                    height: 200,
                    child: Scrollbar(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            (model?.seriesDetailsRec?.seriesRec.isEmpty ?? true)
                                ? 1
                                : model!.seriesDetailsRec?.seriesRec.length,
                        itemExtent:
                            model?.seriesDetailsRec?.seriesRec.isEmpty == false
                                ? 270
                                : 390,
                        itemBuilder: (BuildContext context, int index) {
                          final seriesRec = model?.seriesDetailsRec?.seriesRec;

                          if (seriesRec != null &&
                              seriesRec.isNotEmpty &&
                              index < seriesRec.length) {
                            final title = seriesRec[index].name;
                            final image = seriesRec[index].backdropPath;
                            var voteAverage = (seriesRec[index].voteAverage);
                            voteAverage = voteAverage * 10;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () =>
                                      model?.onMovieTap(context, index),
                                  splashColor: Colors.black,
                                  child: DecoratedBox(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      clipBehavior: Clip.hardEdge,
                                      child: Column(
                                        children: [
                                          image != null
                                              ? Image.network(
                                                  ApiClient.imageUrl(image))
                                              : const Image(
                                                  image: AssetImage(
                                                      'images/place2.png')),
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    title,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  voteAverage
                                                      .toStringAsFixed(0),
                                                  maxLines: 2,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          return const Center(
                            child: Text(
                              'No Recommendations',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 26),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

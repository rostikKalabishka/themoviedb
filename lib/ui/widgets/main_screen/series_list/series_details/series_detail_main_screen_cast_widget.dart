import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:themoviedb/ui/widgets/main_screen/series_list/series_details/series_details_model.dart';
import '../../../../../domain/api_client/network_client.dart';

class SeriesDetailMainScreenCastWidget extends StatelessWidget {
  const SeriesDetailMainScreenCastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SeriesDetailsModel>();

    return ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Series Cast',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 350,
            child: Scrollbar(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: (model.seriesDetails?.credits.cast.length) ?? 0,
                  itemExtent: 170,
                  itemBuilder: (BuildContext context, int index) {
                    if (model.seriesDetails?.credits != null) {
                      final name =
                          model.seriesDetails?.credits.cast[index].name;
                      if (name == null) return const SizedBox.shrink();
                      final profilePath =
                          model.seriesDetails?.credits.cast[index].profilePath;
                      final character =
                          model.seriesDetails?.credits.cast[index].character;
                      if (character == null) return const SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.2)),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2)),
                              ]),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            clipBehavior: Clip.hardEdge,
                            child: Column(
                              children: [
                                profilePath != null
                                    ? Image.network(
                                        NetworkClient.imageUrl(profilePath),
                                      )
                                    : const Image(
                                        height: 230,
                                        width: 150,
                                        image: AssetImage(
                                          'images/unknown1111.jpg',
                                        ),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        character,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        name,
                                        maxLines: 2,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return null;
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

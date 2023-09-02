import 'package:flutter/material.dart';

import 'package:themoviedb/library/widgets/inherited/provider.dart';

import '../../../../../domain/api_client/api_client.dart';
import '../../../../../resources/resources.dart';
import 'movie_details_model.dart';

class MovieDetailsMainRec extends StatelessWidget {
  const MovieDetailsMainRec({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    return ColoredBox(
      color: Colors.white,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  'Recommendations',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: Scrollbar(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 20,
                  itemExtent: 270,
                  itemBuilder: (BuildContext context, int index) {
                    final movieRec = model?.movieDetailRec?.movieRec;
                    final title = movieRec?[index].title;
                    final image = movieRec?[index].backdropPath;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          clipBehavior: Clip.hardEdge,
                          child: Column(
                            children: [
                              image != null
                                  ? Image.network(ApiClient.imageUrl(image))
                                  : const SizedBox.shrink(),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      title ?? '',

                                      // 'Barbie',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    // const SizedBox(height: 5),
                                    // const Text(
                                    //   '73%',
                                    //   maxLines: 2,
                                    // )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

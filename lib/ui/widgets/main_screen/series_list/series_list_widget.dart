import 'package:flutter/material.dart';
import 'package:themoviedb/ui/widgets/main_screen/series_list/series_list_model.dart';

import '../../../../domain/api_client/api_client.dart';
import '../../../../library/widgets/inherited/provider.dart';

class SeriesListWidget extends StatelessWidget {
  const SeriesListWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<SeriesListModel>(context);

    if (model == null) return const SizedBox.shrink();
    return Stack(children: [
      ListView.builder(
          padding: const EdgeInsets.only(top: 80),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: model.series.length,
          itemExtent: 163,
          itemBuilder: (BuildContext context, int index) {
            final listSeries = model.series[index];
            final posterPath = listSeries.posterPath;
            model.showedSeriesAtIndex(index);
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
                          ? Image.network(ApiClient.imageUrl(posterPath))
                          : const SizedBox.shrink(),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              listSeries.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              model.stringFromDate(listSeries.firstAirDate),
                              style: const TextStyle(color: Colors.grey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              listSeries.overview,
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
                    onTap: () => model.onSeriesTap(context, index),
                  ),
                )
              ]),
            );
          }),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          onChanged: model.searchSeries,
          decoration: InputDecoration(
              labelText: 'Search',
              filled: true,
              fillColor: Colors.white.withAlpha(235),
              border: const OutlineInputBorder()),
        ),
      ),
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/domain/api_client/network_client.dart';
import 'package:themoviedb/ui/widgets/main_screen/series_list/series_list_model.dart';

class SeriesListWidget extends StatefulWidget {
  const SeriesListWidget({super.key});

  @override
  State<SeriesListWidget> createState() => _SeriesListWidgetState();
}

class _SeriesListWidgetState extends State<SeriesListWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final locale = Localizations.localeOf(context);
    context.read<SeriesListModel>().setupLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return const Stack(children: [
      ListViewSeries(),
      _SeriesSearch(),
    ]);
  }
}

class _SeriesSearch extends StatelessWidget {
  const _SeriesSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<SeriesListModel>();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        onChanged: model.searchSeries,
        decoration: InputDecoration(
            labelText: 'Search',
            filled: true,
            fillColor: Colors.white.withAlpha(235),
            border: const OutlineInputBorder()),
      ),
    );
  }
}

class ListViewSeries extends StatelessWidget {
  const ListViewSeries({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SeriesListModel>();
    return ListView.builder(
        padding: const EdgeInsets.only(top: 80),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemCount: model.series.length,
        itemExtent: 163,
        itemBuilder: (BuildContext context, int index) {
          model.showedSeriesAtIndex(index);
          return _SeriesListRowWidget(
            index: index,
          );
        });
  }
}

class _SeriesListRowWidget extends StatelessWidget {
  const _SeriesListRowWidget({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final model = context.read<SeriesListModel>();
    final listSeries = model.series[index];
    final posterPath = listSeries.posterPath;
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
                  ? Image.network(NetworkClient.imageUrl(posterPath))
                  : const SizedBox.shrink(),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      listSeries.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      listSeries.firstAirDate,
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
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/ui/widgets/main_screen/series_list/series_details/series_detail_main_info_widgets.dart';
import 'package:themoviedb/ui/widgets/main_screen/series_list/series_details/series_detail_main_rec.dart';
import 'package:themoviedb/ui/widgets/main_screen/series_list/series_details/series_detail_main_screen_cast_widget.dart';
import 'package:themoviedb/ui/widgets/main_screen/series_list/series_details/series_detail_main_social_widget.dart';

import '../../../../Theme/app_bar_style.dart';

import 'series_details_model.dart';

class SeriesDetails extends StatefulWidget {
  const SeriesDetails({super.key});

  @override
  State<SeriesDetails> createState() => _SeriesDetailsState();
}

class _SeriesDetailsState extends State<SeriesDetails> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.watch<SeriesDetailsModel>().setupLocale(context);
    // Future.microtask(
    // () => context.watch<SeriesDetailsModel>().setupLocale(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const _TitleWidget()),
      body: const ColoredBox(
          color: Color.fromRGBO(34, 19, 100, 1), child: _BodyWidget()),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SeriesDetailsModel>();

    return Text(
      model.seriesDetails?.name ?? 'Loading...',
      style: AppColors.textAppBar,
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SeriesDetailsModel>();
    final seriesDetails = model.seriesDetails;
    if (seriesDetails == null) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }
    return ListView(
      children: const [
        SeriesDetailsMainInfoWidget(),
        SizedBox(height: 30),
        SeriesDetailMainScreenCastWidget(),
        SeriesDetailMainSocialWidget(),
        SeriesDetailsMainRec(),
      ],
    );
  }
}

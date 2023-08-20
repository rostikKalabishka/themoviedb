import 'package:flutter/material.dart';
import 'package:themoviedb/widgets/main_screen/movie_list/movie_details/movie_detail_main_info_widgets.dart';

import '../../../../Theme/app_bar_style.dart';
import 'series_detail_main_rec.dart';
import 'series_detail_main_screen_cast_widget.dart';
import 'series_detail_main_social_widget.dart';

class SeriesDetails extends StatefulWidget {
  const SeriesDetails({super.key, required this.seriesId});
  final int seriesId;

  @override
  State<SeriesDetails> createState() => _SeriesDetailsState();
}

class _SeriesDetailsState extends State<SeriesDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Blue Beetle',
          style: AppColors.textAppBar,
        ),
      ),
      body: ColoredBox(
        color: Color.fromRGBO(34, 19, 100, 1),
        child: ListView(
          children: const [
            MovieDetailsMainInfoWidget(),
            SizedBox(height: 30),
            SeriesDetailMainScreenCastWidget(),
            SeriesDetailMainSocialWidget(),
            SeriesDetailsMainRec(),
          ],
        ),
      ),
    );
  }
}

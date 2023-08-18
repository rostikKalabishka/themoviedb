import 'package:flutter/material.dart';
import 'package:themoviedb/widgets/main_screen/movie_list/movie_details/movie_detail_main_info_widgets.dart';

import '../../../../Theme/app_bar_style.dart';
import 'movie_detail_main_screen_cast_widget.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key, required this.mivieId});
  final int mivieId;

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
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
            MovieDetailMainScreenCastWidget(),
          ],
        ),
      ),
    );
  }
}

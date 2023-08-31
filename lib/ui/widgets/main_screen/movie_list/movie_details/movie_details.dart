import 'package:flutter/material.dart';
import 'package:themoviedb/library/widgets/inherited/provider.dart';
import 'package:themoviedb/ui/widgets/main_screen/movie_list/movie_details/movie_detail_main_info_widgets.dart';
import 'package:themoviedb/ui/widgets/main_screen/movie_list/movie_details/movie_details_model.dart';

import '../../../../Theme/app_bar_style.dart';
import 'movie_detail_main_rec.dart';
import 'movie_detail_main_screen_cast_widget.dart';
import 'movie_detail_main_social_widget.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({
    super.key,
  });

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    NotifierProvider.watch<MovieDetailsModel>(context)?.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const _TitleWidget()),
      body: const ColoredBox(
        color: Color.fromRGBO(34, 19, 100, 1),
        child: _BodyWidget(),
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);

    return Text(
      model?.movieDetails?.title ?? 'Loading...',
      style: AppColors.textAppBar,
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final movieDetails = model?.movieDetails;
    if (movieDetails == null) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }
    return ListView(
      children: const [
        MovieDetailsMainInfoWidget(),
        SizedBox(height: 30),
        MovieDetailMainScreenCastWidget(),
        MovieDetailMainSocialWidget(),
        MovieDetailsMainRec(),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    Future.microtask(
        () => context.read<MovieDetailsModel>().setupLocale(context));
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
    final model = context.watch<MovieDetailsModel>();

    return Text(
      model.data.title,
      style: AppColors.textAppBar,
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final model = context.watch<MovieDetailsModel>();
    final isLoading =
        context.select((MovieDetailsModel model) => model.data.isLoading);
    if (isLoading) {
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

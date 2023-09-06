import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SeriesTrailerWidget extends StatefulWidget {
  final String youtubeKey;
  const SeriesTrailerWidget({Key? key, required this.youtubeKey})
      : super(key: key);

  @override
  State<SeriesTrailerWidget> createState() => _SeriesTrailerWidgetState();
}

class _SeriesTrailerWidgetState extends State<SeriesTrailerWidget> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeKey,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            onReady: () {},
          ),
          builder: (context, player) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  'Trailer',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: Center(child: player),
              floatingActionButton: orientation == Orientation.landscape
                  ? FloatingActionButton(
                      onPressed: () {
                        _controller.toggleFullScreenMode();
                      },
                      child: const Icon(Icons.fullscreen_exit),
                    )
                  : null,
            );
          },
        );
      },
    );
  }
}

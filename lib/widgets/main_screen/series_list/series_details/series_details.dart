import 'package:flutter/material.dart';

class SeriesDetails extends StatefulWidget {
  final int seriesId;

  const SeriesDetails({
    super.key,
    required this.seriesId,
  });

  @override
  State<SeriesDetails> createState() => _SeriesDetailsState();
}

class _SeriesDetailsState extends State<SeriesDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Container(
        color: Colors.amber,
        child: Row(
          children: [],
        ),
      ),
    );
  }
}

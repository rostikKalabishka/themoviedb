import 'package:flutter/material.dart';
import 'package:themoviedb/resources/resources.dart';

class MovieDetailMainScreenCastWidget extends StatelessWidget {
  const MovieDetailMainScreenCastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Series Cast',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 230,
            child: Scrollbar(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 20,
                  itemExtent: 120,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.black.withOpacity(0.2)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2)),
                            ]),
                        child: const ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          clipBehavior: Clip.hardEdge,
                          child: Column(
                            children: [
                              Image(
                                  image: AssetImage(AppImages.brunaMarquezine)),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Bruna Marquezine',
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Jenny Kord',
                                      maxLines: 2,
                                    )
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
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Full Cast & Crew',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                )),
          )
        ],
      ),
    );
  }
}

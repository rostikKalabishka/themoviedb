import 'package:flutter/material.dart';

class MovieDetailMainSocialWidget extends StatelessWidget {
  const MovieDetailMainSocialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Social',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text('Discussion',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black)))
              ],
            ),
          ),
          SizedBox(
            height: 110,
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 100,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.black.withOpacity(0.2)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.supervised_user_circle),
                                Text(
                                  'New DC success!',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'on August 18, 2023 at 6:00 AM',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Go to Discussion',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}

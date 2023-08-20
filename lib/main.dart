import 'package:flutter/material.dart';
import 'package:themoviedb/routes/routes.dart';

import 'Theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      initialRoute: '/auth',
      title: 'Flutter Demo',
      theme: theme,
      // home: AuthWidget(),
    );
  }
}
